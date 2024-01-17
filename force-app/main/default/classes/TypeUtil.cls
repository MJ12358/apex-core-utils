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

public inherited sharing class TypeUtil {

/**
 *  Get the type of an object
 *  @param Object
 *  @return System.Type
 */
	public static System.Type get(Object o) {
		if (o == null) {
			return null;
		}
		if (o instanceof SObject) {
			return System.Type.forName(((SObject)o).getSObjectType().getDescribe().getName());
		}
		if (o instanceof Boolean) {
			return System.Type.forName('Boolean');
		}
		if (o instanceof Id) {
			return System.Type.forName('Id');
		}
		if (o instanceof String) {
			return System.Type.forName('String');
		}
		if (o instanceof Blob) {
			return System.Type.forName('Blob');
		}
		if (o instanceof Date) {
			return System.Type.forName('Date');
		}
		if (o instanceof Datetime) {
			return System.Type.forName('Datetime');
		}
		if (o instanceof Time) {
			return System.Type.forName('Time');
		}
		if (o instanceof Integer) {
			return System.Type.forName('Integer');
		}
		if (o instanceof Long) {
			return System.Type.forName('Long');
		}
		if (o instanceof Decimal) {
			return System.Type.forName('Decimal');
		}
		if (o instanceof Double) {
			return System.Type.forName('Double');
		}
    if (o instanceof List<String>) {
			return System.Type.forName('List<String>');
		}
		if (o instanceof List<Object>) {
			return System.Type.forName('List<Object>');
		}
		if (o instanceof Map<String, String>) {
			return System.Type.forName('Map<String, String>');
		}
    if (o instanceof Map<String, Object>) {
			return System.Type.forName('Map<String, Object>');
		}
    if (o instanceof Map<Object, Object>) {
			return System.Type.forName('Map<Object, Object>');
		}
		return System.Type.forName('Object');
	}

/**
 *  The the type of an object as a string
 *  @param Object
 *  @return String
 */
	public static String getAsString(Object o) {
		if (o instanceof List<Object> || 
			o instanceof List<String>) {
			return 'List';
		}
		if (o instanceof Map<Object, Object> || 
			o instanceof Map<String, Object> || 
			o instanceof Map<String, String>) {
			return 'Map';
		}
		return String.valueOf(get(o));
	}

}
