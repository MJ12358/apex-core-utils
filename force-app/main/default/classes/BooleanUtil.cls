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

public class BooleanUtil {

	public static Boolean negate(Boolean value) {
		if (value == null) {
			return false;
		}
		return !value;
	}

	public static Boolean toBoolean(Integer value) {
		if (value != null && value == 1) {
			return true;
		}
		return false;
	}

	public static String toString(Boolean value) {
		if (value != null && value) {
			return 'TRUE';
		}
		return 'FALSE';
	}

	public static String toYesNo(Boolean value) {
		if (value != null && value) {
			return 'YES';
		}
		return 'NO';
	}

	public static String toYN(Boolean value) {
		if (value != null && value) {
			return 'Y';
		}
		return 'N';
	}

	public static Boolean xor(List<Boolean> items) {
		if (items == null || items.isEmpty()) {
			return false;
		}
		Boolean firstItem = items[0];
		for (Boolean item : items) {
			if (item != firstItem) {
				return false;
			}
		}
		return true;
	}

}
