@IsTest
public class HolidayUtilTest {

	private static Date holiday = Date.newInstance(2020, 01, 01);
	private static Datetime holidayDatetime = Datetime.newInstance(2020, 01, 01, 09, 30, 0);
	private static Date notHoliday = Date.newInstance(2020, 01, 02);
	private static Datetime notHolidayDatetime = Datetime.newInstance(2020, 01, 02, 09, 30, 0);

	@TestSetup
	static void testSetup() {
		List<Holiday> holidays = new List<Holiday>();
		Holiday monthly = new Holiday();
		monthly.Name = 'Monthly';
		monthly.ActivityDate = Date.newInstance(2020, 01, 15);
		monthly.RecurrenceStartDate = Date.newInstance(2020, 01, 15);
		monthly.RecurrenceDayOfWeekMask = 1;
		monthly.RecurrenceInstance = 'First';
		monthly.RecurrenceType = 'RecursMonthlyNth';
		monthly.IsRecurrence = true;
		monthly.RecurrenceInterval = 1;
		holidays.add(monthly);
		Holiday weekly = new Holiday();
		weekly.Name = 'Weekly';
		weekly.ActivityDate = Date.newInstance(2020, 01, 08);
		weekly.RecurrenceStartDate = Date.newInstance(2020, 01, 08);
		weekly.RecurrenceDayOfWeekMask = 8;
		weekly.RecurrenceType = 'RecursWeekly';
		weekly.IsRecurrence = true;
		weekly.RecurrenceInterval = 1;
		holidays.add(weekly);
		insert holidays;
	}

	@IsTest
	static void testGetBetweenDates() {
		Date oneYearFromNow = holiday.addYears(1);
		Test.startTest();
		Map<Date, Holiday> results = HolidayUtil.getBetweenDates(holiday, oneYearFromNow);
		Test.stopTest();
		System.assert(results.size() > 0);
	}

	@IsTest
	static void testIsHoliday() {
		Test.startTest();
		Boolean trueResult = HolidayUtil.isHoliday(holiday);
		Boolean falseResult = HolidayUtil.isHoliday(notHoliday);
		Boolean trueDatetime = HolidayUtil.isHoliday(holidayDatetime);
		Boolean falseDatetime = HolidayUtil.isHoliday(notHolidayDatetime);
		Test.stopTest();
		System.assertEquals(true, trueResult);
		System.assertEquals(false, falseResult);
		System.assertEquals(true, trueDatetime);
		System.assertEquals(false, falseDatetime);
	}

}
