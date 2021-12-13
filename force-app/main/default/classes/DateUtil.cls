/**
 * Created on Jul 29 2019
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

public class DateUtil {

	public static final Map<String, Integer> dayByName = new Map<String, Integer>{
		'Sunday' => 0,
		'Monday' => 1,
		'Tuesday' => 2,
		'Wednesday' => 3,
		'Thursday' => 4,
		'Friday' => 5,
		'Saturday' => 6
	};

	public static Boolean isBusinessHours(BusinessHours bh, Datetime dt) {
		return BusinessHours.isWithin(String.valueOf(bh.Id), dt);
	}

	public static Boolean isBusinessHours(Id businessHoursId, Datetime dt) {
		List<BusinessHours> hours = [SELECT Id FROM BusinessHours WHERE Id = :businessHoursId LIMIT 1];
		if (!hours.isEmpty()) {
			return isBusinessHours(hours[0], dt);
		}
		return false;
	}

	public static Boolean isBusinessHours(Datetime dt) {
		List<BusinessHours> hours = [SELECT Id FROM BusinessHours WHERE IsDefault = true LIMIT 1];
		if (!hours.isEmpty()) {
			return isBusinessHours(hours[0], dt);
		}
		return false;
	}

	public static Integer dayOfWeekNumber(Date d) {
		return Math.mod(Date.newInstance(1900, 1, 7).daysBetween(d), 7);
	}

	public static Integer dayOfWeekNumber(Datetime dt) {
		return dayOfWeekNumber(dt.date());
	}

	public static Datetime skipWeekend(Datetime dt, Boolean backwards) {
		Integer dayOfWeek = dayOfWeekNumber(dt);
		switch on dayOfWeek {
			when 6 {
				return dt.addDays(backwards ? -1 : 2);
			}
			when 0 {
				return dt.addDays(backwards ? -2 : 1);
			}
			when else {
				return dt;
			}
		}
	}

	public static Datetime skipWeekend(Datetime dt) {
		return skipWeekend(dt, false);
	}
	
	public static Date skipWeekend(Date d, Boolean backwards) {
		Datetime dt = toDatetime(d);
		return skipWeekend(dt, backwards).date();
	}

	public static Date skipWeekend(Date d) {
		return skipWeekend(d, false);
	}

	public static Datetime skipHolidayAndWeekend(Datetime dt, Boolean backwards) {
		if (HolidayUtil.isHoliday(dt)) {
			return skipWeekend(dt.addDays(backwards ? -1 : 1), backwards);
		}
		return skipWeekend(dt, backwards);
	}

	public static Datetime skipHolidayAndWeekend(Datetime dt) {
		return skipHolidayAndWeekend(dt, false);
	}

	public static Date skipHolidayAndWeekend(Date d, Boolean backwards) {
		Datetime dt = toDatetime(d);
		return skipHolidayAndWeekend(dt, backwards).date();
	}

	public static Date skipHolidayAndWeekend(Date d) {
		return skipHolidayAndWeekend(d, false);
	}

	public static Double getTimeZoneOffset(System.TimeZone tz) {
		return tz.getOffset(Datetime.now()) / (60 * 60 * 1000);
	}

	public static Double getTimeZoneOffset() {
		System.TimeZone tz = System.UserInfo.getTimeZone();
		return getTimeZoneOffset(tz);
	}

	public static Datetime toLocalDatetime(Datetime value) {
		Datetime result = value.date();
		return result.addHours(value.hour())
			.addMinutes(value.minute())
			.addSeconds(value.second());
	}

	//* Unix time

	public static String getUnixTime(String value) {
		try {
			Datetime dt = toDatetime(value);
			return String.valueOf(dt.getTime());
		} catch (System.JSONException e) {
			return value;
		}
	}

	//* Date String

	public static String toDateString(Date d) {
		Datetime dt = toDatetime(d);
		return dateString(dt);
	}

	public static String toDateString(Datetime dt) {
		return dateString(dt);
	}

	public static String toDateString(String value) {
		try {
			Datetime dt = toDatetime(value);
			return dateString(dt);
		} catch (System.JSONException e) {
			return value;
		}
	}

	//* Locale String

	public static String toLocaleString(Date d) {
		Datetime dt = toDatetime(d);
		return localeString(dt);
	}

	public static String toLocaleString(Datetime dt) {
		return localeString(dt);
	}

	public static String toLocaleString(String value) {
		try {
			Datetime dt = toDatetime(value);
			return localeString(dt);
		} catch (System.JSONException e) {
			return value;
		}
	}

	//* Locale Date String

	public static String toLocaleDateString(Date d) {
		Datetime dt = toDatetime(d);
		return localeDateString(dt);
	}

	public static String toLocaleDateString(Datetime dt) {
		return localeDateString(dt);
	}

	public static String toLocaleDateString(String value) {
		try {
			Datetime dt = toDatetime(value);
			return localeDateString(dt);
		} catch (System.JSONException e) {
			return value;
		}
	}

	//* Locale Time String

	public static String toLocaleTimeString(Date d) {
		Datetime dt = toDatetime(d);
		return localeTimeString(dt);
	}

	public static String toLocaleTimeString(Datetime dt) {
		return localeTimeString(dt);
	}

	public static String toLocaleTimeString(String value) {
		try {
			Datetime dt = toDatetime(value);
			return localeTimeString(dt);
		} catch (System.JSONException e) {
			return value;
		}
	}

	//* ISO String

	public static String toIsoString(Date d) {
		Datetime dt = toDatetime(d);
		return isoString(dt);
	}

	public static String toIsoString(Datetime dt) {
		return isoString(dt);
	}

	public static String toIsoString(String value) {
		try {
			Datetime dt = toDatetime(value);
			return isoString(dt);
		} catch (System.JSONException e) {
			return value;
		}
	}

	//* ISO Date String

	public static String toIsoDateString(Date d) {
		Datetime dt = toDatetime(d);
		return isoDateString(dt);
	}

	public static String toIsoDateString(Datetime dt) {
		return isoDateString(dt);
	}

	public static String toIsoDateString(String value) {
		try {
			Datetime dt = toDatetime(value);
			return isoDateString(dt);
		} catch (System.JSONException e) {
			return value;
		}
	}

	//* ISO Time String

	public static String toIsoTimeString(Date d) {
		Datetime dt = toDatetime(d);
		return isoTimeString(dt);
	}

	public static String toIsoTimeString(Datetime dt) {
		return isoTimeString(dt);
	}

	public static String toIsoTimeString(Time t) {
		Datetime dt = toDatetime(t);
		return isoTimeString(dt);
	}

	public static String toIsoTimeString(String value) {
		try {
			Datetime dt = toDatetime(value);
			return isoTimeString(dt);
		} catch (System.JSONException e) {
			return value;
		}
	}

	//* To String

	public static String toString(Date d) {
		Datetime dt = toDatetime(d);
		return string(dt);
	}

	public static String toString(Datetime dt) {
		return string(dt);
	}

	public static String toString(String value) {
		try {
			Datetime dt = toDatetime(value);
			return string(dt);
		} catch (System.JSONException e) {
			return value;
		}
	}

	//* Time String

	public static String toTimeString(Date d) {
		Datetime dt = toDatetime(d);
		return timeString(dt);
	}

	public static String toTimeString(Datetime dt) {
		return timeString(dt);
	}

	public static String toTimeString(String value) {
		try {
			Datetime dt = toDatetime(value);
			return timeString(dt);
		} catch (System.JSONException e) {
			return value;
		}
	}

	//* UTC String

	public static String toUtcString(Date d) {
		Datetime dt = toDatetime(d);
		return utcString(dt);
	}

	public static String toUtcString(Datetime dt) {
		return utcString(dt);
	}

	public static String toUtcString(String value) {
		try {
			Datetime dt = toDatetime(value);
			return utcString(dt);
		} catch (System.JSONException e) {
			return value;
		}
	}

	//* Utility methods

	public static Date deserializeDate(String value) {
		return (Date)System.JSON.deserialize(System.JSON.serialize(value), Date.class);
	}

	public static Datetime deserializeDatetime(String value) {
		return (Datetime)System.JSON.deserialize(System.JSON.serialize(value), Datetime.class);
	}

	public static Time deserializeTime(String value) {
		return (Time)System.JSON.deserialize(System.JSON.serialize(value), Time.class);
	}

	public static Date toDate(Datetime dt) {
		return Date.newInstance(dt.year(), dt.month(), dt.day());
	}

	public static Date toDate(String value) {
		try {
			return Date.valueOf(value);
		} catch (System.TypeException e) {
			try {
				return Date.parse(value);
			} catch (System.TypeException ex) {
				return deserializeDate(value);
			}
		}
	}

	public static Datetime toDatetime(Date d) {
		return Datetime.newInstance(d.year(), d.month(), d.day(), 0, 0, 0);
	}

	public static Datetime toDatetime(Time t) {
		return Datetime.newInstance(0, 0, 0, t.hour(), t.minute(), t.second());
	}

	public static Datetime toDatetime(String value) {
		try {
			return Datetime.valueOf(value);
		} catch (System.TypeException e) {
			try {
				return Datetime.parse(value);
			} catch (System.TypeException ex) {
				return deserializeDatetime(value);
			}
		}
	}

	public static Time toTime(Datetime dt) {
		return Time.newInstance(dt.hour(), dt.minute(), dt.second(), dt.millisecond());
	}

	public static Time toTime(String value) {
		try {
			Datetime dt = Datetime.valueOf(value);
			return toTime(dt);
		} catch (System.TypeException e) {
			try {
				Datetime dt = Datetime.parse(value);
				return toTime(dt);
			} catch (System.TypeException ex) {
				Datetime dt = deserializeDatetime(value);
				return toTime(dt);
			}
		}
	}

	public static Datetime fromMMDDYYYY(String value) {
		if (String.isBlank(value)) return null;
		List<String> split = value.split('\\D');
		if (split.size() != 3) {
			return null;
		}
		return Datetime.newInstance(Integer.valueOf(split[2]), Integer.valueOf(split[0]), Integer.valueOf(split[1]), 0, 0, 0);
	}

	public static Datetime fromYYYYMMDD(String value) {
		if (String.isBlank(value)) return null;
		List<String> split = value.split('\\D');
		if (split.size() != 3) {
			return null;
		}
		return Datetime.newInstance(Integer.valueOf(split[0]), Integer.valueOf(split[1]), Integer.valueOf(split[2]), 0, 0, 0);
	}

	public static Date toEndOfMonth(Date value) {
		Integer lastDayOfMonth = Date.daysInMonth(value.year(), value.month());
		return Date.newInstance(value.year(), value.month(), lastDayOfMonth);
	}

	public static Date toEndOfMonth(Datetime value) {
		return toEndOfMonth(Date.newInstance(value.year(), value.month(), value.day()));
	}

	//* Formater methods
	// 		heavily influnced by the way javascript does it

	private static String dateString(Datetime dt) {
		return dt.format('EEE MMM dd yyyy');
	}

	private static String localeString(Datetime dt) {
		return dt.format('MM/dd/yyyy, h:mm:ss a');
	}

	private static String localeDateString(Datetime dt) {
		return dt.format('MM/dd/yyyy');
	}

	private static String localeTimeString(Datetime dt) {
		return dt.format('h:mm:ss a');
	}

	private static String isoString(Datetime dt) {
		return dt.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
	}

	private static String isoDateString(Datetime dt) {
		return dt.format('yyyy-MM-dd');
	}

	private static String isoTimeString(Datetime dt) {
		return dt.format('HH:mm:ss.SSS\'Z\'');
	}

	private static String string(Datetime dt) {
		return dt.format('EEE MMM dd yyyy HH:mm:ss zz');
	}

	private static String timeString(Datetime dt) {
		return dt.format('kk:mm:ss zz');
	}

	private static String utcString(Datetime dt) {
		return dt.formatGmt('EEE, dd MMM yyyy HH:mm:ss');
	}

}
