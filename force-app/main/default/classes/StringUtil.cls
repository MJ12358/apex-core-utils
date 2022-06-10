/**
 * Created on Thur Aug 8 2019
 *
 * Copyright (c) 2019 Matt Jants
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

public inherited sharing class StringUtil {

  public static final String EMPTY = '';
  public static final String SPACE = ' ';
  public static final String CR = '\r';
  public static final String LF = '\n';
  public static final String CRLF = '\r\n';
  public static final Set<String> LOWERCASE_WORDS = new Set<String>{
    'a', 'an', 'and', 'as', 'at',
    'but', 'for', 'in', 'is', 'nor',
    'of', 'or', 'the', 'to', 'with'
  };
  public static final Set<String> UPPERCASE_WORDS = new Set<String>{
    'st', 'rd', 'pl', 'ne', 'nw', 'se', 'sw'
  };
  public static final Set<String> RESERVED_WORDS = new Set<String>{
    'abstract', 'activate', 'and', 'any', 'array', 'as', 'asc', 'autonomous',
    'begin', 'bigdecimal', 'blob', 'break', 'bulk', 'by', 'byte',
    'case', 'cast', 'catch', 'char', 'class', 'collect', 'commit', 'const', 'continue', 'convertcurrency',
    'decimal', 'default', 'delete', 'desc', 'do',
    'else', 'end', 'enum', 'exception', 'exit', 'export', 'extends',
    'false', 'final', 'finally', 'float', 'for', 'from', 'future',
    'global', 'goto', 'group',
    'having', 'hint',
    'if', 'implements', 'import', 'in', 'inner', 'insert', 'instanceof', 'interface', 'into', 'int',
    'join',
    'last_90_days', 'last_month', 'last_n_days', 'last_week', 'like', 'limit', 'list', 'long', 'loop',
    'map', 'merge',
    'new', 'next_90_days', 'next_month', 'next_n_days', 'next_week', 'not', 'null', 'nulls', 'number',
    'object', 'of', 'on', 'or', 'outter', 'override',
    'package', 'parallel', 'pragma', 'private', 'protected', 'public',
    'retrieve', 'return', 'returning', 'rollback',
    'savepoint', 'search', 'select', 'set', 'short', 'sort', 'stat', 'static', 'super', 'system', 'switch', 'syncronized',
    'testmethod', 'then', 'this', 'this_month', 'this_week', 'throw', 'today', 'tolabel', 'tomorrow', 'transaction', 'trigger', 'true', 'try', 'type',
    'undelete', 'update', 'upsert', 'using',
    'virtual', 
    'webservice', 'when', 'where', 'while',
    'yesterday'
  };
  public static final Set<String> VOWELS = new Set<String>{
    'a', 'e', 'i', 'o', 'u'
  };

/**
 *  Get digits from a string
 *  @param String
 *  @return String
 */
  public static String getDigits(String str) {
    return String.isNotBlank(str) ? str.replaceAll('\\D', '') : str;
  }

/**
 *  Get first name from a string
 *  @param String
 *  @return String
 */
  public static String getFirstName(String name) {
    if (String.isBlank(name)) {
      return name;
    }
    return name.split(' ')[0];
  }

/**
 *  Get last name from a string
 *  @param String
 *  @return String
 */
  public static String getLastName(String name) {
    if (String.isBlank(name)) {
      return name;
    }
    List<String> nameParts = name.split(' ');
    if (nameParts.size() > 1) {
      return name.substring(name.indexOf(' ') + 1);
    }
    return name;
  }

/**
 *  Format a phone number
 *  @param String
 *  @return String
 */
  public static String formatPhoneNumber(String value) {
    if (String.isBlank(value)) {
      return value;
    }
    String s = getDigits(value);
    // NANP (North American Numbering Plan)
    if (s.length() == 10) {
      return String.format('({0}) {1}-{2}',
        new List<String>{
          s.substring(0, 3),
          s.substring(3, 6),
          s.substring(6)
        }
      );
    // NANP with country code (trunk code)
    } else if (s.length() == 11) {
      return String.format('({0}) {1}-{2}',
        new List<String>{
          s.substring(1, 4),
          s.substring(4, 7),
          s.substring(7)
        }
      );
    // subscriber number only
    } else if (s.length() == 7) {
      return String.format('{0}-{1}',
        new List<String>{
          s.substring(0, 3),
          s.substring(3)
        }
      );
    }
    return value;
  }

/**
 *  Get indefinite article from a string
 *  @param String
 *  @return String
 */
  public static String getIndefiniteArticle(String word) {
    if (String.isBlank(word)) {
      return word;
    }
    return VOWELS.contains(word.split('')[0].toLowerCase()) ? 'an' : 'a';
  }

/**
 *  Mogrify JSON
 *  @param String json
 *  @param Map<String,String> replacements
 *  @return String
 */
  public static String mogrifyJSON(String json, Map<String, String> replacements) {
    String regexFormat = '(?m)^\\s*"{0}"\\s*:';
    String replacementFormat = '"{0}" :';
    String formattedJSON = System.JSON.serializePretty(System.JSON.deserializeUntyped(json));
    for (String key : replacements.keySet()) {
      String regex = String.format(regexFormat,
        new List<String>{ key }
      );
      String replacement = String.format(replacementFormat,
        new List<String>{ replacements.get(key) }
      );
      formattedJSON = formattedJSON.replaceAll(regex, replacement);
    }
    return formattedJSON;
  }

/**
 *  Title case a string
 *  @param String
 *  @return String
 */
  public static String toTitleCase(String s) {
    if (String.isBlank(s)) {
      return s;
    }
    List<String> words = s.toLowerCase().normalizeSpace().split(' ');
    String result = words[0].capitalize();
    for (Integer i = 1; i < words.size(); i++) {
      if (LOWERCASE_WORDS.contains(words[i])) {
        result += ' ' + words[i];
      } else if (UPPERCASE_WORDS.contains(words[i])) {
        result += ' ' + words[i].toUpperCase();
      } else {
        result += ' ' + words[i].capitalize();
      }
    }
    return result;
  }

/**
 *  Normalize keys of json (respecting reserved words)
 *    this is usually used when keys from an api
 *    are among the reserved words in Apex
 *  @param String
 *  @return String
 */
  public static String normalizeKeys(String json) {
    for (String s : RESERVED_WORDS) {
      String replacee = '"' + s + '":';
      String replacer = '"' + s + 'x":';
      json = json.replace(replacee, replacer);
    }
    return json;
  }

/**
 *  Reverse the normailzation of keys
 *    this is used to reverse the normaization used above
 *  @param String
 *  @return String
 */
  public static String normalizeKeysReverse(String json) {
    for (String s : RESERVED_WORDS) {
      String replacee = '"' + s + 'x":';
      String replacer = '"' + s + '":';
      json = json.replace(replacee, replacer);
    }
    return json;
  }

/**
 *  Safe split a string
 *  @param String input
 *  @param String delimiter
 */
  public static List<String> safeSplit(String input, String delim) {
    Integer regexFindLimit = 100;
    Integer regexFindCount = 0;
    List<String> output = new List<String>();
    Matcher m = Pattern.compile(delim).matcher(input);
    Integer lastEnd = 0;
    while (!m.hitEnd()) {
      while (regexFindCount < regexFindLimit && !m.hitEnd()) {
        if (m.find()) {
          output.add(input.substring(lastEnd, m.start())); 
          lastEnd = m.end();
        } else {
          output.add(input.substring(lastEnd));
          lastEnd = input.length();
        }
        regexFindCount++;
      }
      // Note: Using region() to advance instead of substring() saves
      // drastically on heap size. Nonetheless, we still must reset the
      // (unmodified) input sequence to avoid a 'Regex too complicated'
      // error.
      m.reset(input);       
      m.region(lastEnd, m.regionEnd());
      regexFindCount = 0;
    }
    return output;
  }

/**
 *  Check if a string is an IP address
 *  @param String
 *  @return Boolean
 */
  public static Boolean isIpAddress(String value) {
    if (String.isBlank(value)) {
      return false;
    }
    // ipv4
    if (value.split('\\.').size() == 4) {
      Integer i;
      for (String octet : value.split('\\.')) {
        try {
          i = Integer.valueOf(octet);
        } catch (System.TypeException e) {
          return false;
        }
        if (i < 0 || i > 255) {
          return false;
        }
      }
      return true;
    }
    // ipv6
    if (value.split('\\:').size() == 8) {
      for (String hextet : value.split('\\:')) {
        for (String s : hextet.split('')) {
          if (!NumberUtil.HEX.contains(s.toUpperCase())) {
            return false;
          }
        }
      }
      return true;
    }
    return false;
  }

/**
 *  Check if a string is an email address
 *  @param String
 *  @return Boolean
 */
  public static Boolean isEmailAddress(String value) {
    if (String.isNotBlank(value)) {
      List<String> split = value.split('@');
      if (split.size() == 2) {
        split = split[1].split('\\.');
        if (split.size() == 2) {
          return true;
        }
      }
    }
    return false;
  }
  
}