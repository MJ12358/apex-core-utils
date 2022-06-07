/**
 * Created on Sat Feb 6 2021
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

public inherited sharing class BooleanUtil {

/**
 * 	Negates the incoming boolean
 * 	@param Boolean
 *	@return Boolean
 */
	public static Boolean negate(Boolean value) {
		if (value == null) {
			return false;
		}
		return !value;
	}

/**
 * 	Converts an object to a boolean
 * 	@param Object
 * 	@return Boolean
 */
  public static Boolean toBoolean(Object value) {
		if (value == null) {
      return false;
    }

    if (value instanceof Integer || value instanceof Decimal || value instanceof Double) {
      Integer i = Integer.valueOf(value);
      if (i == 1) {
        return true;
      }
      return false;
    }

    if (value instanceof String) {
      String s = String.valueOf(value);
      switch on s.toUpperCase() {
        when 'TRUE', 'YES', 'Y' {
          return true;
        }
        when else {
          return false;
        }
      }
    }

    return false;
	}

/**
 * 	Converts a boolean to a string
 * 	@param Boolean
 * 	@return String either 'TRUE' or 'FALSE'
 */
	public static String toString(Boolean value) {
		if (value != null && value) {
			return 'TRUE';
		}
		return 'FALSE';
	}

/**
 *	Converts a boolean to a string
 *	@param Boolean
 *	@return String either 'YES' or 'NO'
 */
	public static String toYesNo(Boolean value) {
		if (value != null && value) {
			return 'YES';
		}
		return 'NO';
	}

/**
 *	Converts a boolean to a string
 *	@param Boolean
 *	@return String either 'Y' or 'N'
 */
	public static String toYN(Boolean value) {
		if (value != null && value) {
			return 'Y';
		}
		return 'N';
	}

}
