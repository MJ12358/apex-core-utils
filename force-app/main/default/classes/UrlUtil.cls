/**
 * Created on Fri Jun 10 2022
 *
 * Copyright (c) 2022 MJ12358
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

public inherited sharing class UrlUtil {

/**
 *  Get the orgs base url
 *  @return String
 */
  public static String getBase() {
    return System.Url.getOrgDomainUrl().toExternalForm();
  }
  
/**
 *  Get the orgs domain name
 *  @return String
 */
  public static String getDomainName() {
    String url = System.Url.getSalesforceBaseUrl().getHost();
    return url.split('\\.')[0];
  }

/**
 *  Get the orgs lightning base url
 *  @return String
 */
  public static String getLightningBase() {
    String domain = getDomainName();
    if (domain.contains('--')) {
      domain = domain.substring(0, domain.lastIndexOf('--'));
    }
    return 'https://' + domain + '.lightning.force.com';
  }

/**
 *  Get the orgs visualforce base url
 *  @return String
 */
  public static String getVisualforceBase() {
    String result = '';
    String domain = getDomainName();
    Organization org = [SELECT InstanceName, IsSandbox, NamespacePrefix FROM Organization];
    String namespace = '--' + (String.isNotBlank(org.NamespacePrefix) ? org.NamespacePrefix : 'c');
    
    // workaround for lightning context hostname including the namespace
    if (domain.containsIgnoreCase(namespace)) {
      domain = domain.substring(0, domain.lastIndexOf(namespace));
    }

    // summer '20 updated domain urls for sandboxes
    if (org.IsSandbox) {
      result = String.format('https://{0}{1}.visualforce.com',
        new List<String>{
          domain,
          namespace
        }
      );
    } else {
      result = String.format('https://{0}{1}.{2}.visual.force.com',
        new List<String>{
          domain,
          namespace,
          org.InstanceName.toLowerCase()
        }
      );
    }

    return result;
  }

/**
 *  Get the orgs document/content base url
 *  @return String
 */
  public static String getDocumentforceBase() {
    String result = '';
    String domain = getDomainName();
    Organization org = [SELECT InstanceName, IsSandbox, NamespacePrefix FROM Organization];
    String namespace = '--' + (String.isNotBlank(org.NamespacePrefix) ? org.NamespacePrefix : 'c');
    
    // summer '20 updated domain urls for sandboxes
    if (org.IsSandbox) {
      result = String.format('https://{0}{1}.documentforce.com',
        new List<String>{
          domain,
          namespace
        }
      );
    } else {
      result = String.format('https://{0}{1}.{2}.content.force.com',
        new List<String>{
          domain,
          namespace,
          org.InstanceName.toLowerCase()
        }
      );
    }
    
    return result;
  }

/**
 *  The a site url by its name
 *  @param String
 *  @return String
 */
  public static String getSiteUrl(String siteName) {
    String result = '';
    Site site;
    try {
      site = [SELECT Subdomain, UrlPathPrefix FROM Site WHERE Name = :siteName];
    } catch (System.QueryException e) {
      return null;
    }
    
    Organization org = [SELECT InstanceName, IsSandbox FROM Organization];

    if (org.isSandbox) {
      String sandboxName = getDomainName().substringAfter('--');
      result = String.format('https://{0}-{1}.{2}.force.com/{3}',
        new List<String>{
          sandboxName,
          site.Subdomain,
          org.InstanceName.toLowerCase(),
          site.UrlPathPrefix
        }
      );
    } else {
      result = String.format('https://{0}.force.com/{2}',
        new List<String>{
          site.Subdomain,
          site.UrlPathPrefix
        }
      );
    }

    return result;
  }

}
