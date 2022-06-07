/**
 * Created on Feb 15 2021
 *
 * Copyright (c) 2021 Matt Jants
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 *    are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, 
 *    this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, 
 *    this list of conditions and the following disclaimer in the documentation 
 *    and/or other materials provided with the distribution.
 * - Neither the name of the company, software or the names of its contributors 
 *    may be used to endorse or promote products derived from this software without 
 *    specific prior written permission.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 *  TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 *  THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, TORT (INCLUDING NEGLIGENCE) OR OTHERWISE, 
 *  ARISING FROM, OUT OF OR IN CONNECTION WITH THE USE OF THIS SOFTWARE OR OTHER DEALINGS IN THE SOFTWARE, 
 *  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

public inherited sharing class MergeFieldUtil {

/**
 *  Resolve the incoming template
 *  @param SObject
 *  @param String The template
 *  @return String
 */
  public static String resolve(SObject sObj, String template) {
    List<String> fields = getFieldsFromTemplate(template);
    for (String fieldName : fields) {
      String key = '\\{!' + fieldName + '\\}';
      try {
        Object fieldValue = getFieldValue(sObj, fieldName);
        template = template.replaceAll(key, String.valueOf(fieldValue));
      } catch (Exception e) {
        // ignore field not queried errors
      }
    }
    return resolveGlobals(template);
  }

/**
 *  Resolve the incoming template
 *  @param Id The sObject record id
 *  @param String The template
 *  @return String
 */
  public static String resolve(Id recordId, String template) {
    List<String> fields = getFieldsFromTemplate(template);
    String query = String.format('SELECT {0} FROM {1} WHERE Id = :recordId',
      new List<String>{
        String.join(fields, ','),
        recordId.getSObjectType().getDescribe().getName()
      }
    );
    SObject sObj = Database.query(query);
    return resolve(sObj, template);
  }

/**
 *  Get all fields from a template (excluding globals)
 *  @param String The template
 *  @return List<String>
 */
  public static List<String> getFieldsFromTemplate(String template) {
    Set<String> results = new Set<String>();
    String regex = '\\{!([^$]+?)\\}';
    Pattern p = Pattern.compile(regex);
    Matcher m = p.matcher(template);
    while (m.find()) {
      results.add(m.group(1));
    }
    return new List<String>(results);
  }

/**
 *  Resolve globals from the incoming template
 *  @param String The template
 *  @return String
 */
  public static String resolveGlobals(String template) {
    Set<String> globals = new Set<String>();
    String regex = '\\{!\\$(.+?)\\}';
    Pattern p = Pattern.compile(regex);
    Matcher m = p.matcher(template);
    while (m.find()) {
      globals.add(m.group(1));
    }
    for (String key : globals) {
      List<String> split = key.split('\\.');
      if (split.size() != 2) {
        continue;
      }
      key = '\\{!\\$' + key + '\\}';
      String glob = split[0].toLowerCase(); // global is a reserved word
      String prop = split[1].toLowerCase();
      switch on glob {
        // user globals
        when 'user' {
          switch on prop {
            when 'name' {
              template = template.replaceAll(key, System.UserInfo.getName());
            }
            when 'firstname' {
              template = template.replaceAll(key, System.UserInfo.getFirstName());
            }
            when 'lastname' {
              template = template.replaceAll(key, System.UserInfo.getLastName());
            }
            when 'email' {
              template = template.replaceAll(key, System.UserInfo.getUserEmail());
            }
            when 'companyname' {
              template = template.replaceAll(key, System.UserInfo.getOrganizationName());
            }
          }
        }
        // TODO: parse other globals here
      }
    }
    return template;
  }

/**
 *  Get an sObject field value from a string (supports dot notation)
 *  @param String
 *  @return Object
 *    this comes from the SObjectUtil
 *    but to reduce dependencies it is duplicated here
 */
  private static Object getFieldValue(SObject sObj, String field) {
    if (sObj == null || String.isBlank(field)) {
      return null;
    }
    List<String> fieldSplit = field.split('\\.');
    if (fieldSplit.size() > 1) {
      Integer count = 0;
      SObject parentRecord = sObj.getSObject(fieldSplit[count++]);
      while (count < fieldSplit.size() - 1) {
        parentRecord = parentRecord.getSObject(fieldSplit[count]);
        count++;
      }
      // ensure the relationship is not null
      if (parentRecord != null && String.isNotBlank(fieldSplit[count])) {
        return parentRecord.get(fieldSplit[count]);
      }
      return null;
    }
    return sObj.get(field);
  }

}
