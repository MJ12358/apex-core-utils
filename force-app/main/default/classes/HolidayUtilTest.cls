@IsTest
public class HolidayUtilTest {

  private static Date newYears = Date.newInstance(2020, 01, 01);
  private static Datetime newYearsDatetime = Datetime.newInstance(2020, 01, 01, 09, 30, 0);
  private static Date notNewYears = Date.newInstance(2020, 01, 02);
  private static Datetime notNewYearsDatetime = Datetime.newInstance(2020, 01, 02, 09, 30, 0);

  @TestSetup
  static void testSetup() {
    List<Holiday> holidays = new List<Holiday>();

    Holiday h = new Holiday();
    h.Name = 'New Years';
    h.ActivityDate = newYears;
    h.IsRecurrence = true;
    h.RecurrenceStartDate = newYears;
    h.RecurrenceType = 'RecursYearly';
    h.RecurrenceDayOfMonth = 1;
    h.RecurrenceMonthOfYear = 'January';
    holidays.add(h);

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
    Date oneYearFromNow = newYears.addYears(1);
    Test.startTest();
    Map<Date, Holiday> results = HolidayUtil.getBetweenDates(newYears, oneYearFromNow);
    Test.stopTest();
    System.assert(results.size() > 0);
  }

  @IsTest
  static void testIsHoliday() {
    Test.startTest();
    Boolean trueResult = HolidayUtil.isHoliday(newYears);
    Boolean falseResult = HolidayUtil.isHoliday(notNewYears);
    Boolean trueDatetime = HolidayUtil.isHoliday(newYearsDatetime);
    Boolean falseDatetime = HolidayUtil.isHoliday(notNewYearsDatetime);
    Test.stopTest();
    System.assertEquals(true, trueResult);
    System.assertEquals(false, falseResult);
    System.assertEquals(true, trueDatetime);
    System.assertEquals(false, falseDatetime);
  }

}
