@IsTest
public class DateUtilTest {

	private static Date aDate = Date.newInstance(2020, 1, 1);
	private static Datetime aDatetime = Datetime.newInstanceGmt(2020, 1, 1, 0, 0, 0);
	private static String iso8601 = '2020-01-01T00:00:00.000Z';
	private static String iso8601Date = '2020-01-01';
	private static String iso8601Time = '00:00:00.000Z';
	private static String rfc2822 = 'Wed, 01 Jan 2020 00:00:00';
	private static String rfc3339 = '2020-01-01 00:00:00';
	private static String altString = '01/01/2020 12:00 AM';
	private static String failure = 'failure';
	private static User usr = [SELECT Id FROM User WHERE TimeZoneSidKey = 'GMT' LIMIT 1];
	private static BusinessHours bh = [SELECT Id FROM BusinessHours WHERE IsDefault = true LIMIT 1];

	@TestSetup
	static void testSetup() {
		User usr = new User();
		usr.Username = 'TestUser0';
		insert usr;
	}

	@IsTest
	static void testIsBusinessHours() {
		Datetime isBh = Datetime.newInstanceGmt(2020, 1, 1, 14, 30, 0);
		Datetime notBh = Datetime.newInstanceGmt(2020, 1, 1, 2, 30, 0);
		Test.startTest();
		Boolean isTrue = DateUtil.isBusinessHours(isBh);
		Boolean isFalse = DateUtil.isBusinessHours(notBh);
		Boolean isTrue2 = DateUtil.isBusinessHours(bh.Id, isBh);
		Boolean isFalse2 = DateUtil.isBusinessHours(bh.Id, notBh);
		Test.stopTest();
		// allData or createData
		// System.assertEquals(true, isTrue);
		// System.assertEquals(false, isFalse);
	}

	@IsTest
	static void testDayOfWeekNumber() {
		Date wed = Date.newInstance(2020, 1, 1);
		Date thur = Date.newInstance(2020, 1, 2);
		Date fri = Date.newInstance(2020, 1, 3);
		Date sat = Date.newInstance(2020, 1, 4);
		Date sun = Date.newInstance(2020, 1, 5);
		Date mon = Date.newInstance(2020, 1, 6);
		Date tue = Date.newInstance(2020, 1, 7);
		Test.startTest();
		Integer weds = DateUtil.dayOfWeekNumber(wed);
		Integer thurs = DateUtil.dayOfWeekNumber(thur);
		Integer fris = DateUtil.dayOfWeekNumber(fri);
		Integer sats = DateUtil.dayOfWeekNumber(sat);
		Integer suns = DateUtil.dayOfWeekNumber(sun);
		Integer mons = DateUtil.dayOfWeekNumber(mon);
		Integer tues = DateUtil.dayOfWeekNumber(tue);
		Test.stopTest();
		System.assertEquals(3, weds);
		System.assertEquals(4, thurs);
		System.assertEquals(5, fris);
		System.assertEquals(6, sats);
		System.assertEquals(0, suns);
		System.assertEquals(1, mons);
		System.assertEquals(2, tues);
	}

	@IsTest
	static void testSkipWeekend() {
		Date wed = Date.newInstance(2020, 1, 1);
		Date thur = Date.newInstance(2020, 1, 2);
		Date fri = Date.newInstance(2020, 1, 3);
		Date sat = Date.newInstance(2020, 1, 4);
		Date sun = Date.newInstance(2020, 1, 5);
		Date mon = Date.newInstance(2020, 1, 6);
		Date tue = Date.newInstance(2020, 1, 7);
		Test.startTest();
		Date weds = DateUtil.skipWeekend(wed);
		Date thurs = DateUtil.skipWeekend(thur);
		Date fris = DateUtil.skipWeekend(fri);
		Date sats = DateUtil.skipWeekend(sat);
		Date suns = DateUtil.skipWeekend(sun);
		Date mons = DateUtil.skipWeekend(mon);
		Date tues = DateUtil.skipWeekend(tue);
		Test.stopTest();
		System.assertEquals('1/1/2020', weds.format());
		System.assertEquals('1/2/2020', thurs.format());
		System.assertEquals('1/3/2020', fris.format());
		System.assertEquals('1/6/2020', sats.format());
		System.assertEquals('1/6/2020', suns.format());
		System.assertEquals('1/6/2020', mons.format());
		System.assertEquals('1/7/2020', tues.format());
	}

	@IsTest
	static void testSkipHolidayAndWeekend() {
		Date holiday = Date.newInstance(2020, 1, 1);
		Date notHoliday = Date.newInstance(2020, 1, 2);
		Test.startTest();
		Date dayAfterHoliday = DateUtil.skipHolidayAndWeekend(holiday);
		Date dayOfNotHoliday = DateUtil.skipHolidayAndWeekend(notHoliday);
		Test.stopTest();
		System.assertEquals('1/2/2020', dayAfterHoliday.format());
		System.assertEquals('1/2/2020', dayOfNotHoliday.format());
	}

	@IsTest
	static void testGetTimezoneOffset() {
		System.runAs(usr) {
			Test.startTest();
			Double tzo = DateUtil.getTimezoneOffset();
			Test.stopTest();
			System.assertEquals(0, tzo);
		}
	}

	@IsTest
	static void testToLocalDatetime() {
		Test.startTest();
		Datetime result = DateUtil.toLocalDatetime(aDatetime);
		Test.stopTest();
		System.assertNotEquals(null, result);
	}

	//* Unix time

	@IsTest
	static void testGetUnixTime() {
		System.runAs(usr) {
			Test.startTest();
			String iso8601t = DateUtil.getUnixTime(iso8601);
			String rfc3339t = DateUtil.getUnixTime(rfc3339);
			// String altStringt = DateUtil.getUnixTime(altString);
			Test.stopTest();
			System.assertEquals('1577836800000', iso8601t);
			System.assertEquals('1577836800000', rfc3339t);
			// returns 'value' hmmm...
			// System.assertEquals('1577836800000', altStringt);
		}
	}

	@IsTest
	static void testGetUnixTimeError() {
		Test.startTest();
		String result = DateUtil.getUnixTime(failure);
		Test.stopTest();
		System.assertEquals(failure, result);
	}

	//* Date String

	@IsTest
	static void testToDateString() {
		System.runAs(usr) {
			Test.startTest();
			String aDatet = DateUtil.toDateString(aDate);
			String aDatetimet = DateUtil.toDateString(aDatetime);
			String iso8601t = DateUtil.toDateString(iso8601);
			String rfc3339t = DateUtil.toDateString(rfc3339);
			Test.stopTest();
			System.assertEquals('Wed Jan 01 2020', aDatet);
			System.assertEquals('Wed Jan 01 2020', aDatetimet);
			System.assertEquals('Wed Jan 01 2020', iso8601t);
			System.assertEquals('Wed Jan 01 2020', rfc3339t);
		}
	}

	@IsTest
	static void testToDateStringError() {
		Test.startTest();
		String result = DateUtil.toDateString(failure);
		Test.stopTest();
		System.assertEquals(failure, result);
	}

	//* Locale String

	@IsTest
	static void testToLocaleString() {
		System.runAs(usr) {
			Test.startTest();
			String aDatet = DateUtil.toLocaleString(aDate);
			String aDatetimet = DateUtil.toLocaleString(aDatetime);
			String iso8601t = DateUtil.toLocaleString(iso8601);
			String rfc3339t = DateUtil.toLocaleString(rfc3339);
			Test.stopTest();
			System.assertEquals('01/01/2020, 12:00:00 AM', aDatet);
			System.assertEquals('01/01/2020, 12:00:00 AM', aDatetimet);
			System.assertEquals('01/01/2020, 12:00:00 AM', iso8601t);
			System.assertEquals('01/01/2020, 12:00:00 AM', rfc3339t);
		}
	}

	@IsTest
	static void testToLocaleStringError() {
		Test.startTest();
		String result = DateUtil.toLocaleString(failure);
		Test.stopTest();
		System.assertEquals(failure, result);
	}

	@IsTest
	static void testToLocaleDateString() {
		System.runAs(usr) {
			Test.startTest();
			String aDatet = DateUtil.toLocaleDateString(aDate);
			String aDatetimet = DateUtil.toLocaleDateString(aDatetime);
			String iso8601t = DateUtil.toLocaleDateString(iso8601);
			String rfc3339t = DateUtil.toLocaleDateString(rfc3339);
			Test.stopTest();
			System.assertEquals('01/01/2020', aDatet);
			System.assertEquals('01/01/2020', aDatetimet);
			System.assertEquals('01/01/2020', iso8601t);
			System.assertEquals('01/01/2020', rfc3339t);
		}
	}

	@IsTest
	static void testToLocaleDateStringError() {
		Test.startTest();
		String result = DateUtil.toLocaleDateString(failure);
		Test.stopTest();
		System.assertEquals(failure, result);
	}

	//* Locale Time String

	@IsTest
	static void testToLocaleTimeString() {
		System.runAs(usr) {
			Test.startTest();
			String aDatet = DateUtil.toLocaleTimeString(aDate);
			String aDatetimet = DateUtil.toLocaleTimeString(aDatetime);
			String iso8601t = DateUtil.toLocaleTimeString(iso8601);
			String rfc3339t = DateUtil.toLocaleTimeString(rfc3339);
			Test.stopTest();
			System.assertEquals('12:00:00 AM', aDatet);
			System.assertEquals('12:00:00 AM', aDatetimet);
			System.assertEquals('12:00:00 AM', iso8601t);
			System.assertEquals('12:00:00 AM', rfc3339t);
		}
	}

	@IsTest
	static void testToLocaleTimeStringError() {
		Test.startTest();
		String result = DateUtil.toLocaleTimeString(failure);
		Test.stopTest();
		System.assertEquals(failure, result);
	}

	//* ISO String

	@IsTest
	static void testToISOString() {
		System.runAs(usr) {
			Test.startTest();
			String aDatet = DateUtil.toISOString(aDate);
			String aDatetimet = DateUtil.toISOString(aDatetime);
			String iso8601t = DateUtil.toISOString(iso8601);
			String rfc3339t = DateUtil.toISOString(rfc3339);
			Test.stopTest();
			System.assertEquals('2020-01-01T00:00:00.000Z', aDatet);
			System.assertEquals('2020-01-01T00:00:00.000Z', aDatetimet);
			System.assertEquals('2020-01-01T00:00:00.000Z', iso8601t);
			System.assertEquals('2020-01-01T00:00:00.000Z', rfc3339t);
		}
	}

	@IsTest
	static void testToISOStringError() {
		Test.startTest();
		String result = DateUtil.toISOString(failure);
		Test.stopTest();
		System.assertEquals(failure, result);
	}

	//* ISO Date String

	@IsTest
	static void testToISODateString() {
		System.runAs(usr) {
			Test.startTest();
			String aDatet = DateUtil.toISODateString(aDate);
			String aDatetimet = DateUtil.toISODateString(aDatetime);
			String iso8601t = DateUtil.toISODateString(iso8601);
			String rfc3339t = DateUtil.toISODateString(rfc3339);
			Test.stopTest();
			System.assertEquals('2020-01-01', aDatet);
			System.assertEquals('2020-01-01', aDatetimet);
			System.assertEquals('2020-01-01', iso8601t);
			System.assertEquals('2020-01-01', rfc3339t);
		}
	}

	@IsTest
	static void testToISODateStringError() {
		Test.startTest();
		String result = DateUtil.toISODateString(failure);
		Test.stopTest();
		System.assertEquals(failure, result);
	}

	//* ISO Time String

	@IsTest
	static void testToISOTimeString() {
		System.runAs(usr) {
			Test.startTest();
			String aDatet = DateUtil.toISOTimeString(aDate);
			String aDatetimet = DateUtil.toISOTimeString(aDatetime);
			String iso8601t = DateUtil.toISOTimeString(iso8601);
			String rfc3339t = DateUtil.toISOTimeString(rfc3339);
			Test.stopTest();
			System.assertEquals('00:00:00.000Z', aDatet);
			System.assertEquals('00:00:00.000Z', aDatetimet);
			System.assertEquals('00:00:00.000Z', iso8601t);
			System.assertEquals('00:00:00.000Z', rfc3339t);
		}
	}

	@IsTest
	static void testToISOTimeStringError() {
		Test.startTest();
		String result = DateUtil.toISOTimeString(failure);
		Test.stopTest();
		System.assertEquals(failure, result);
	}

	//* To String

	@IsTest
	static void testToString() {
		System.runAs(usr) {
			Test.startTest();
			String aDatet = DateUtil.toString(aDate);
			String aDatetimet = DateUtil.toString(aDatetime);
			String iso8601t = DateUtil.toString(iso8601);
			String rfc3339t = DateUtil.toString(rfc3339);
			Test.stopTest();
			System.assertEquals('Wed Jan 01 2020 00:00:00 GMT', aDatet);
			System.assertEquals('Wed Jan 01 2020 00:00:00 GMT', aDatetimet);
			System.assertEquals('Wed Jan 01 2020 00:00:00 GMT', iso8601t);
			System.assertEquals('Wed Jan 01 2020 00:00:00 GMT', rfc3339t);
		}
	}

	@IsTest
	static void testToStringError() {
		Test.startTest();
		String result = DateUtil.toString(failure);
		Test.stopTest();
		System.assertEquals(failure, result);
	}

	//* Time String

	@IsTest
	static void testToTimeString() {
		System.runAs(usr) {
			Test.startTest();
			String aDatet = DateUtil.toTimeString(aDate);
			String aDatetimet = DateUtil.toTimeString(aDatetime);
			String iso8601t = DateUtil.toTimeString(iso8601);
			String rfc3339t = DateUtil.toTimeString(rfc3339);
			Test.stopTest();
			System.assertEquals('24:00:00 GMT', aDatet);
			System.assertEquals('24:00:00 GMT', aDatetimet);
			System.assertEquals('24:00:00 GMT', iso8601t);
			System.assertEquals('24:00:00 GMT', rfc3339t);
		}
	}

	@IsTest
	static void testToTimeStringError() {
		Test.startTest();
		String result = DateUtil.toTimeString(failure);
		Test.stopTest();
		System.assertEquals(failure, result);
	}

	//* UTC String

	@IsTest
	static void testToUTCString() {
		System.runAs(usr) {
			Test.startTest();
			String aDatet = DateUtil.toUTCString(aDate);
			String aDatetimet = DateUtil.toUTCString(aDatetime);
			String iso8601t = DateUtil.toUTCString(iso8601);
			String rfc3339t = DateUtil.toUTCString(rfc3339);
			Test.stopTest();
			System.assertEquals('Wed, 01 Jan 2020 00:00:00', aDatet);
			System.assertEquals('Wed, 01 Jan 2020 00:00:00', aDatetimet);
			System.assertEquals('Wed, 01 Jan 2020 00:00:00', iso8601t);
			System.assertEquals('Wed, 01 Jan 2020 00:00:00', rfc3339t);
		}
	}

	@IsTest
	static void testToUTCStringError() {
		Test.startTest();
		String result = DateUtil.toUTCString(failure);
		Test.stopTest();
		System.assertEquals(failure, result);
	}

	@IsTest
	static void testFromMMDDYYYY() {
		Test.startTest();
		Datetime aDatet = DateUtil.fromMMDDYYYY('01-01-2020');
		Datetime bDatet = DateUtil.fromMMDDYYYY('01/01/2020');
		Datetime fail = DateUtil.fromMMDDYYYY(rfc2822);
		Test.stopTest();
		System.assertEquals('2020-01-01 00:00:00', String.valueOf(aDatet));
		System.assertEquals('2020-01-01 00:00:00', String.valueOf(bDatet));
		System.assertEquals(null, fail);
	}

	@IsTest
	static void testFromYYYYMMDD() {
		Test.startTest();
		Datetime aDatet = DateUtil.fromYYYYMMDD('2020-01-01');
		Datetime bDatet = DateUtil.fromYYYYMMDD('2020/01/01');
		Datetime fail = DateUtil.fromYYYYMMDD(rfc2822);
		Test.stopTest();
		System.assertEquals('2020-01-01 00:00:00', String.valueOf(aDatet));
		System.assertEquals('2020-01-01 00:00:00', String.valueOf(bDatet));
		System.assertEquals(null, fail);
	}

	@IsTest
	static void testEndOfMonth() {
		Test.startTest();
		Date endOfMonth = DateUtil.toEndOfMonth(Datetime.newInstance(2020, 1, 1));
		Test.stopTest();
		System.assertEquals('2020-01-31', String.valueOf(endOfMonth));
	}

	@IsTest
	static void testToDate() {
		Test.startTest();
		Date d1 = DateUtil.toDate(Datetime.now());
		Date d2 = DateUtil.toDate('2020-01-31');
		Test.stopTest();
		System.assertNotEquals(null, d1);
		System.assertNotEquals(null, d2);
	}

	@IsTest
	static void testToTime() {
		Test.startTest();
		Time t1 = DateUtil.toTime(Datetime.now());
		Time t2 = DateUtil.toTime(iso8601);
		Test.stopTest();
		System.assertNotEquals(null, t1);
		System.assertNotEquals(null, t2);
	}

}
