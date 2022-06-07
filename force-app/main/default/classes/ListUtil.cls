/**
 * Created on Feb 5 2021
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

/**
 *  The reason for all the overloads is to allow for the
 *    same data type that was passed in to be returned
 */

public inherited sharing class ListUtil {

/**
 *  Chunk an array by the given split size
 *  @param List<String>
 *  @param Integer The size of the child arrays
 *  @return List<List<String>>
 */
  public static List<List<String>> chunk(List<String> items, Integer size) {
    List<List<String>> results = new List<List<String>>();
    List<String> tempList = new List<String>();
    // a for loop with two counters.
    Integer index = 0;
    Integer count = 0;
    while (index < items.size()) {
      tempList.add(items[index++]);
      count++;
      // split size reached, add to results and make new list
      if (count == size) {
        results.add(tempList);
        tempList = new List<String>();
        count = 0;
      }
    }
    // add left-over partial
    if (!tempList.isEmpty()) {
      results.add(tempList);
    }
    return results;
  }

  public static List<List<String>> chunk(Set<String> items, Integer size) {
    return chunk(new List<String>(items), size);
  }

/**
 *  List contains a value ignoring the case
 *  @param List<String>
 *  @param String
 *  @return Boolean
 */
  public static Boolean containsIgnoreCase(List<String> items, String value) {
    for (String s : items) {
      if (s == null && value == null) {
        return true;
      }
      if (s != null && value != null) {
        if (s.toLowerCase() == value.toLowerCase()) {
          return true;
        }
      }
    }
    return false;
  }

  public static Boolean containsIgnoreCase(Set<String> items, String value) {
    return containsIgnoreCase(new List<String>(items), value);
  }

/**
 *  Lowercase elements in a list
 *  @param List<String>
 *  @return List<String>
 */
  public static List<String> toLowerCase(List<String> items) {
    List<String> results = new List<String>();
    if (items != null) {
      for (String s : items) {
        if (String.isNotBlank(s)) {
          results.add(s.toLowerCase());
        }
      }
    }
    return results;
  }

  public static Set<String> toLowerCase(Set<String> items) {
    List<String> results = toLowerCase(new List<String>(items));
    return new Set<String>(results);
  }

/**
 *  Uppercase elements in a list
 *  @param List<String>
 *  @return List<String>
 */
  public static List<String> toUpperCase(List<String> items) {
    List<String> results = new List<String>();
    if (items != null) {
      for (String s : items) {
        if (String.isNotBlank(s)) {
          results.add(s.toUpperCase());
        }
      }
    }
    return results;
  }

  public static Set<String> toUpperCase(Set<String> items) {
    List<String> results = toUpperCase(new List<String>(items));
    return new Set<String>(results);
  }

/**
 *  Return the left most characters
 *  @param List<String>
 *  @param Integer
 *  @return List<String>
 */
  public static List<String> left(List<String> items, Integer length) {
    List<String> results = new List<String>();
    if (items != null && length != null) {
      for (String s : items) {
        results.add(s.left(length));
      }
    }
    return results;
  }

  public static Set<String> left(Set<String> items, Integer length) {
    List<String> results = left(new List<String>(items), length);
    return new Set<String>(results);
  }

/**
 *  Return the mid characters
 *  @param List<String>
 *  @param Integer The startIndex
 *  @param Integer The length
 *  @return List<String>
 */
  public static List<String> mid(List<String> items, Integer startIndex, Integer length) {
    List<String> results = new List<String>();
    if (items != null && startIndex != null && length != null) {
      for (String s : items) {
        results.add(s.mid(startIndex, length));
      }
    }
    return results;
  }

  public static Set<String> mid(Set<String> items, Integer startIndex, Integer length) {
    List<String> results = mid(new List<String>(items), startIndex, length);
    return new Set<String>(results);
  }

/**
 *  Return the right most characters
 *  @param List<String>
 *  @param Integer
 *  @return List<String>
 */
  public static List<String> right(List<String> items, Integer length) {
    List<String> results = new List<String>();
    if (items != null && length != null) {
      for (String s : items) {
        results.add(s.right(length));
      }
    }
    return results;
  }

  public static Set<String> right(Set<String> items, Integer length) {
    List<String> results = right(new List<String>(items), length);
    return new Set<String>(results);
  }

/**
 *  Pluck field values from a list of sObjects
 *  @param List<SObject>
 *  @param String The field name
 *  @return List<Object>
 */
  public static List<Object> pluck(List<SObject> items, String fieldName) {
    List<Object> results = new List<Object>(items.size());
    if (items != null && String.isNotBlank(fieldName)) {
      for (Integer i = 0; i < items.size(); i++) {
        results[i] = items[i].get(fieldName);
      }
    }
    return results;
  }

  public static List<Object> pluck(List<SObject> items, Schema.SObjectField field) {
    return pluck(items, field.getDescribe().getName());
  }

/**
 *  Reverse elements in a list
 *  @param List<Object>
 *  @return List<Object>
 */
  public static List<Object> reverse(List<Object> items) {
    if (items != null) {
      Integer i = 0;
      Integer j = items.size() - 1;
      while (j > i) {
        Object tmp = items[j];
        items[j] = items[i];
        items[i] = tmp;
        i++;
        j--;
      }
    }
    return items;
  }

  public static Set<Object> reverse(Set<Object> items) {
    List<Object> results = reverse(new List<Object>(items));
    return new Set<Object>(results);
  }

  // blob

  public static List<Blob> reverse(List<Blob> items) {
    return toBlob(reverse(toObject(items)));
  }

  public static Set<Blob> reverse(Set<Blob> items) {
    List<Blob> results = reverse(new List<Blob>(items));
    return new Set<Blob>(results);
  }

  // boolean

  public static List<Boolean> reverse(List<Boolean> items) {
    return toBoolean(reverse(toObject(items)));
  }

  public static Set<Boolean> reverse(Set<Boolean> items) {
    List<Boolean> results = reverse(new List<Boolean>(items));
    return new Set<Boolean>(results);
  }

  // date

  public static List<Date> reverse(List<Date> items) {
    return toDate(reverse(toObject(items)));
  }

  public static Set<Date> reverse(Set<Date> items) {
    List<Date> results = reverse(new List<Date>(items));
    return new Set<Date>(results);
  }

  // datetime

  public static List<Datetime> reverse(List<Datetime> items) {
    return toDatetime(reverse(toObject(items)));
  }

  public static Set<Datetime> reverse(Set<Datetime> items) {
    List<Datetime> results = reverse(new List<Datetime>(items));
    return new Set<Datetime>(results);
  }

  // decimal

  public static List<Decimal> reverse(List<Decimal> items) {
    return toDecimal(reverse(toObject(items)));
  }

  public static Set<Decimal> reverse(Set<Decimal> items) {
    List<Decimal> results = reverse(new List<Decimal>(items));
    return new Set<Decimal>(results);
  }

  // double

  public static List<Double> reverse(List<Double> items) {
    return toDouble(reverse(toObject(items)));
  }

  public static Set<Double> reverse(Set<Double> items) {
    List<Double> results = reverse(new List<Double>(items));
    return new Set<Double>(results);
  }

  // id

  public static List<Id> reverse(List<Id> items) {
    return toId(reverse(toObject(items)));
  }

  public static Set<Id> reverse(Set<Id> items) {
    List<Id> results = reverse(new List<Id>(items));
    return new Set<Id>(results);
  }

  // integer

  public static List<Integer> reverse(List<Integer> items) {
    return toInteger(reverse(toObject(items)));
  }

  public static Set<Integer> reverse(Set<Integer> items) {
    List<Integer> results = reverse(new List<Integer>(items));
    return new Set<Integer>(results);
  }

  // long

  public static List<Long> reverse(List<Long> items) {
    return toLong(reverse(toObject(items)));
  }

  public static Set<Long> reverse(Set<Long> items) {
    List<Long> results = reverse(new List<Long>(items));
    return new Set<Long>(results);
  }

  // time

  public static List<Time> reverse(List<Time> items) {
    return toTime(reverse(toObject(items)));
  }

  public static Set<Time> reverse(Set<Time> items) {
    List<Time> results = reverse(new List<Time>(items));
    return new Set<Time>(results);
  }

  // string

  public static List<String> reverse(List<String> items) {
    return toString(reverse(toObject(items)));
  }

  public static Set<String> reverse(Set<String> items) {
    List<String> results = reverse(new List<String>(items));
    return new Set<String>(results);
  }

  // sObject

  public static List<SObject> reverse(List<SObject> items) {
    return toSObject(reverse(toObject(items)));
  }

  public static Set<SObject> reverse(Set<SObject> items) {
    List<SObject> results = reverse(new List<SObject>(items));
    return new Set<SObject>(results);
  }

/**
 *  Sort elements in a set (lists have a built in method)
 *  @param List<Object>
 *  @return List<Object>
 */
  public static Set<Object> sort(Set<Object> items) {
    List<Object> results = new List<Object>();
    if (items != null) {
      results.addAll(items);
      results.sort();
    }
    return new Set<Object>(results);
  }

  // boolean

  public static Set<Boolean> sort(Set<Boolean> items) {
    return toBoolean(sort(toObject(items)));
  }

  // date

  public static Set<Date> sort(Set<Date> items) {
    return toDate(sort(toObject(items)));
  }

  // datetime

  public static Set<Datetime> sort(Set<Datetime> items) {
    return toDatetime(sort(toObject(items)));
  }

  // decimal

  public static Set<Decimal> sort(Set<Decimal> items) {
    return toDecimal(sort(toObject(items)));
  }

  // double

  public static Set<Double> sort(Set<Double> items) {
    return toDouble(sort(toObject(items)));
  }

  // id

  public static Set<Id> sort(Set<Id> items) {
    return toId(sort(toObject(items)));
  }

  // integer

  public static Set<Integer> sort(Set<Integer> items) {
    return toInteger(sort(toObject(items)));
  }

  // long

  public static Set<Long> sort(Set<Long> items) {
    return toLong(sort(toObject(items)));
  }

  // time

  public static Set<Time> sort(Set<Time> items) {
    return toTime(sort(toObject(items)));
  }

  // string

  public static Set<String> sort(Set<String> items) {
    return toString(sort(toObject(items)));
  }

  // sObject

  public static Set<SObject> sort(Set<SObject> items) {
    return toSObject(sort(toObject(items)));
  }

/**
 *  Trim elements in a list
 *  @param List<String>
 *  @return List<String>
 */
  public static List<String> trim(List<String> items) {
    List<String> results = new List<String>();
    if (items != null) {
      for (String s : items) {
        results.add(s.trim());
      }
    }
    return results;
  }

  public static Set<String> trim(Set<String> items) {
    List<String> results = trim(new List<String>(items));
    return new Set<String>(results);
  }

/**
 *  Get unique elements from a list
 *  @param List<Object>
 *  @return List<Object>
 */
  public static List<Object> unique(List<Object> items) {
    List<Object> results = new List<Object>();
    Set<Object> keys = new Set<Object>();
    if (items != null) {
      for (Object obj : items) {
        if (keys.contains(obj)) {
          continue;
        } else {
          keys.add(obj);
          results.add(obj);
        }
      }
    }
    return results;
  }

  public static Set<Object> unique(Set<Object> items) {
    List<Object> results = unique(new List<Object>(items));
    return new Set<Object>(results);
  }

  // blob

  public static List<Blob> unique(List<Blob> items) {
    return toBlob(unique(toObject(items)));
  }

  public static Set<Blob> unique(Set<Blob> items) {
    List<Blob> results = unique(new List<Blob>(items));
    return new Set<Blob>(results);
  }

  // boolean

  public static List<Boolean> unique(List<Boolean> items) {
    return toBoolean(unique(toObject(items)));
  }

  public static Set<Boolean> unique(Set<Boolean> items) {
    List<Boolean> results = unique(new List<Boolean>(items));
    return new Set<Boolean>(results);
  }

  // date

  public static List<Date> unique(List<Date> items) {
    return toDate(unique(toObject(items)));
  }

  public static Set<Date> unique(Set<Date> items) {
    List<Date> results = unique(new List<Date>(items));
    return new Set<Date>(results);
  }

  // datetime

  public static List<Datetime> unique(List<Datetime> items) {
    return toDatetime(unique(toObject(items)));
  }

  public static Set<Datetime> unique(Set<Datetime> items) {
    List<Datetime> results = unique(new List<Datetime>(items));
    return new Set<Datetime>(results);
  }

  // decimal

  public static List<Decimal> unique(List<Decimal> items) {
    return toDecimal(unique(toObject(items)));
  }

  public static Set<Decimal> unique(Set<Decimal> items) {
    List<Decimal> results = unique(new List<Decimal>(items));
    return new Set<Decimal>(results);
  }

  // double

  public static List<Double> unique(List<Double> items) {
    return toDouble(unique(toObject(items)));
  }

  public static Set<Double> unique(Set<Double> items) {
    List<Double> results = unique(new List<Double>(items));
    return new Set<Double>(results);
  }

  // id

  public static List<Id> unique(List<Id> items) {
    return toId(unique(toObject(items)));
  }

  public static Set<Id> unique(Set<Id> items) {
    List<Id> results = unique(new List<Id>(items));
    return new Set<Id>(results);
  }

  // integer

  public static List<Integer> unique(List<Integer> items) {
    return toInteger(unique(toObject(items)));
  }

  public static Set<Integer> unique(Set<Integer> items) {
    List<Integer> results = unique(new List<Integer>(items));
    return new Set<Integer>(results);
  }

  // long

  public static List<Long> unique(List<Long> items) {
    return toLong(unique(toObject(items)));
  }

  public static Set<Long> unique(Set<Long> items) {
    List<Long> results = unique(new List<Long>(items));
    return new Set<Long>(results);
  }

  // time

  public static List<Time> unique(List<Time> items) {
    return toTime(unique(toObject(items)));
  }

  public static Set<Time> unique(Set<Time> items) {
    List<Time> results = unique(new List<Time>(items));
    return new Set<Time>(results);
  }

  // string

  public static List<String> unique(List<String> items) {
    return toString(unique(toObject(items)));
  }

  public static Set<String> unique(Set<String> items) {
    List<String> results = unique(new List<String>(items));
    return new Set<String>(results);
  }

  // sObject

  public static List<SObject> unique(List<SObject> items) {
    return toSObject(unique(toObject(items)));
  }

  public static Set<SObject> unique(Set<SObject> items) {
    List<SObject> results = unique(new List<SObject>(items));
    return new Set<SObject>(results);
  }

  //* Converters

  // blob

  public static List<Blob> toBlob(List<Object> items) {
    List<Blob> results = new List<Blob>();
    if (items != null) {
      for (Object o : items) {
        results.add((Blob)o);
      }
    }
    return results;
  }

  public static Set<Blob> toBlob(Set<Object> items) {
    List<Blob> results = toBlob(new List<Object>(items));
    return new Set<Blob>(results);
  }

  public static List<Object> toObject(List<Blob> items) {
    List<Object> results = new List<Object>();
    if (items != null) {
      for (Blob i : items) {
        results.add(i);
      }
    }
    return results;
  }

  public static Set<Object> toObject(Set<Blob> items) {
    List<Object> results = toObject(new List<Blob>(items));
    return new Set<Object>(results);
  }

  // boolean

  public static List<Boolean> toBoolean(List<Object> items) {
    List<Boolean> results = new List<Boolean>();
    if (items != null) {
      for (Object o : items) {
        results.add((Boolean)o);
      }
    }
    return results;
  }

  public static Set<Boolean> toBoolean(Set<Object> items) {
    List<Boolean> results = toBoolean(new List<Object>(items));
    return new Set<Boolean>(results);
  }

  public static List<Object> toObject(List<Boolean> items) {
    List<Object> results = new List<Object>();
    if (items != null) {
      for (Boolean i : items) {
        results.add(i);
      }
    }
    return results;
  }

  public static Set<Object> toObject(Set<Boolean> items) {
    List<Object> results = toObject(new List<Boolean>(items));
    return new Set<Object>(results);
  }

  // date

  public static List<Date> toDate(List<Object> items) {
    List<Date> results = new List<Date>();
    if (items != null) {
      for (Object o : items) {
        results.add((Date)o);
      }
    }
    return results;
  }

  public static Set<Date> toDate(Set<Object> items) {
    List<Date> results = toDate(new List<Object>(items));
    return new Set<Date>(results);
  }

  public static List<Object> toObject(List<Date> items) {
    List<Object> results = new List<Object>();
    if (items != null) {
      for (Date i : items) {
        results.add(i);
      }
    }
    return results;
  }

  public static Set<Object> toObject(Set<Date> items) {
    List<Object> results = toObject(new List<Date>(items));
    return new Set<Object>(results);
  }

  // datetime

  public static List<Datetime> toDatetime(List<Object> items) {
    List<Datetime> results = new List<Datetime>();
    if (items != null) {
      for (Object o : items) {
        results.add((Datetime)o);
      }
    }
    return results;
  }

  public static Set<Datetime> toDatetime(Set<Object> items) {
    List<Datetime> results = toDatetime(new List<Object>(items));
    return new Set<Datetime>(results);
  }

  public static List<Object> toObject(List<Datetime> items) {
    List<Object> results = new List<Object>();
    if (items != null) {
      for (Datetime i : items) {
        results.add(i);
      }
    }
    return results;
  }

  public static Set<Object> toObject(Set<Datetime> items) {
    List<Object> results = toObject(new List<Datetime>(items));
    return new Set<Object>(results);
  }

  // decimal

  public static List<Decimal> toDecimal(List<Object> items) {
    List<Decimal> results = new List<Decimal>();
    if (items != null) {
      for (Object o : items) {
        results.add((Decimal)o);
      }
    }
    return results;
  }

  public static Set<Decimal> toDecimal(Set<Object> items) {
    List<Decimal> results = toDecimal(new List<Object>(items));
    return new Set<Decimal>(results);
  }

  public static List<Object> toObject(List<Decimal> items) {
    List<Object> results = new List<Object>();
    if (items != null) {
      for (Decimal i : items) {
        results.add(i);
      }
    }
    return results;
  }

  public static Set<Object> toObject(Set<Decimal> items) {
    List<Object> results = toObject(new List<Decimal>(items));
    return new Set<Object>(results);
  }

  // double

  public static List<Double> toDouble(List<Object> items) {
    List<Double> results = new List<Double>();
    if (items != null) {
      for (Object o : items) {
        results.add((Double)o);
      }
    }
    return results;
  }

  public static Set<Double> toDouble(Set<Object> items) {
    List<Double> results = toDouble(new List<Object>(items));
    return new Set<Double>(results);
  }

  public static List<Object> toObject(List<Double> items) {
    List<Object> results = new List<Object>();
    if (items != null) {
      for (Double i : items) {
        results.add(i);
      }
    }
    return results;
  }

  public static Set<Object> toObject(Set<Double> items) {
    List<Object> results = toObject(new List<Double>(items));
    return new Set<Object>(results);
  }

  // id

  public static List<Id> toId(List<Object> items) {
    List<Id> results = new List<Id>();
    if (items != null) {
      for (Object o : items) {
        results.add((Id)o);
      }
    }
    return results;
  }

  public static Set<Id> toId(Set<Object> items) {
    List<Id> results = toId(new List<Object>(items));
    return new Set<Id>(results);
  }

  public static List<Object> toObject(List<Id> items) {
    List<Object> results = new List<Object>();
    if (items != null) {
      for (Id i : items) {
        results.add(i);
      }
    }
    return results;
  }

  public static Set<Object> toObject(Set<Id> items) {
    List<Object> results = toObject(new List<Id>(items));
    return new Set<Object>(results);
  }

  // integer

  public static List<Integer> toInteger(List<Object> items) {
    List<Integer> results = new List<Integer>();
    if (items != null) {
      for (Object o : items) {
        results.add((Integer)o);
      }
    }
    return results;
  }

  public static Set<Integer> toInteger(Set<Object> items) {
    List<Integer> results = toInteger(new List<Object>(items));
    return new Set<Integer>(results);
  }

  public static List<Object> toObject(List<Integer> items) {
    List<Object> results = new List<Object>();
    if (items != null) {
      for (Integer i : items) {
        results.add(i);
      }
    }
    return results;
  }

  public static Set<Object> toObject(Set<Integer> items) {
    List<Object> results = toObject(new List<Integer>(items));
    return new Set<Object>(results);
  }

  // long

  public static List<Long> toLong(List<Object> items) {
    List<Long> results = new List<Long>();
    if (items != null) {
      for (Object o : items) {
        results.add((Long)o);
      }
    }
    return results;
  }

  public static Set<Long> toLong(Set<Object> items) {
    List<Long> results = toLong(new List<Object>(items));
    return new Set<Long>(results);
  }

  public static List<Object> toObject(List<Long> items) {
    List<Object> results = new List<Object>();
    if (items != null) {
      for (Long i : items) {
        results.add(i);
      }
    }
    return results;
  }

  public static Set<Object> toObject(Set<Long> items) {
    List<Object> results = toObject(new List<Long>(items));
    return new Set<Object>(results);
  }

  // time

  public static List<Time> toTime(List<Object> items) {
    List<Time> results = new List<Time>();
    if (items != null) {
      for (Object o : items) {
        results.add((Time)o);
      }
    }
    return results;
  }

  public static Set<Time> toTime(Set<Object> items) {
    List<Time> results = toTime(new List<Object>(items));
    return new Set<Time>(results);
  }

  public static List<Object> toObject(List<Time> items) {
    List<Object> results = new List<Object>();
    if (items != null) {
      for (Time i : items) {
        results.add(i);
      }
    }
    return results;
  }

  public static Set<Object> toObject(Set<Time> items) {
    List<Object> results = toObject(new List<Time>(items));
    return new Set<Object>(results);
  }

  // string

  public static List<String> toString(List<Object> items) {
    List<String> results = new List<String>();
    if (items != null) {
      for (Object o : items) {
        results.add((String)o);
      }
    }
    return results;
  }

  public static Set<String> toString(Set<Object> items) {
    List<String> results = toString(new List<Object>(items));
    return new Set<String>(results);
  }

  public static List<Object> toObject(List<String> items) {
    List<Object> results = new List<Object>();
    if (items != null) {
      for (String i : items) {
        results.add(i);
      }
    }
    return results;
  }

  public static Set<Object> toObject(Set<String> items) {
    List<Object> results = toObject(new List<String>(items));
    return new Set<Object>(results);
  }

  // sObject

  public static List<SObject> toSObject(List<Object> items) {
    List<SObject> results = new List<SObject>();
    if (items != null) {
      for (Object o : items) {
        results.add((SObject)o);
      }
    }
    return results;
  }

  public static Set<SObject> toSObject(Set<Object> items) {
    List<SObject> results = toSObject(new List<Object>(items));
    return new Set<SObject>(results);
  }

  public static List<Object> toObject(List<SObject> items) {
    List<Object> results = new List<Object>();
    if (items != null) {
      for (SObject i : items) {
        results.add(i);
      }
    }
    return results;
  }

  public static Set<Object> toObject(Set<SObject> items) {
    List<Object> results = toObject(new List<SObject>(items));
    return new Set<Object>(results);
  }

}
