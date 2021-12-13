/**
 * Created on Nov 7 2019
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

public without sharing class NumberUtil {

	public static final Integer MAX_INTEGER = 2147483647;
  public static final Integer MIN_INTEGER = -2147483647;
	public static final Long MAX_LONG = 9223372036854775807L;
	public static final Long MIN_LONG = -9223372036854775807L;
	public static final List<String> HEX = new List<String>{'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};

	public static String generateGuid() {
		Blob b = System.Crypto.GenerateAESKey(128);
		String h = System.EncodingUtil.ConvertToHex(b);
		return String.format('{0}-{1}-{2}-{3}-{4}',
			new List<String>{
				h.substring(0,8),
				h.substring(8,12),
				h.substring(12,16),
				h.substring(16,20),
				h.substring(20)
			}
		);
	}

	public static Long generateRandomNumber(Integer length) {
		Double MIN = Math.pow(10, length - 1);
		Double MAX = Math.pow(10, length) - 1;
		return Math.roundToLong(Math.random() * (MAX - MIN) + MIN);
	}

	public static Integer hexToInt(String str) {
		if (String.isBlank(str)) {
			return null;
		}
		str = str.toUpperCase();
		List<String> hexValue = str.split('');
		Integer result = 0;
		for (Integer i = 0; i < hexValue.size(); i++) {
			result = (result << 4) + HEX.indexOf(hexValue[i]);
		}
		return result;
	}

	public static String intToHex(Integer num) {
		if (num == null) {
			return null;
		}
		Integer rem;
		String result = '';
		while (num > 0) {
			rem = (Integer)Math.mod(num, 16);
			result = HEX[rem] + result;
			num = num / 16;
		}
		return result.leftPad(1, '0');
	}

	public static Double toRadians(Decimal degree) {
		return degree * Math.PI / 180;
	}

	public static Decimal getHaversineDistance(Decimal lat1, Decimal lng1, Decimal lat2, Decimal lng2) {
		if (lat1 == lat2 && lng1 == lng2) {
			return 0;
		}
		Double radius = 3958.75;
		Double dLat = toRadians(lat2 - lat1);
		Double dLng = toRadians(lng2 - lng1);
		Double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
							 Math.cos(toRadians(lat1)) * Math.cos(toRadians(lat2)) *
							 Math.sin(dLng / 2) * Math.sin(dLng / 2);
		Double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
		return radius * c;
	}

	public static Boolean isNaN(Object o) {
		return o == null || !(o instanceof Decimal || o instanceof Double || o instanceof Integer || o instanceof Long);
	}

	public static Integer getMax(List<Integer> values) {
		Integer max = MIN_INTEGER;
		for (Integer i : values) {
			if (i > max) {
				max = i;
			}
		}
		return max;
	}

	public static Integer getMin(List<Integer> values) {
		Integer min = MAX_INTEGER;
		for (Integer i : values) {
			if (i < min) {
				min = i;
			}
		}
		return min;
	}

	public static Decimal getMax(List<Decimal> values) {
		Decimal max = Decimal.valueOf(MIN_LONG);
		for (Decimal d : values) {
			if (d > max) {
				max = d;
			}
		}
		return max;
	}

	public static Decimal getMin(List<Decimal> values) {
		Decimal min = Decimal.valueOf(MAX_LONG);
		for (Decimal d : values) {
			if (d < min) {
				min = d;
			}
		}
		return min;
	}

	public static String getOrdinal(Object value) {
		if (value == null) {
			return String.valueOf(value);
		}
		List<String> suffixes = new List<String>{ 'th', 'st', 'nd', 'rd', 'th' ,'th', 'th', 'th', 'th', 'th' };
		switch on Math.mod(Integer.valueOf(value), 100) {
			when 11, 12, 13 {
				return value + 'th';
			}
			when else {
				return value + suffixes.get(Math.mod(Integer.valueOf(value), 10));
			}
		}
	}

}