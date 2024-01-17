/**
 * Created on Jan 4 2021
 *
 * Copyright (c) 2021 MJ12358
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
 *  Inspiration for this came from this post:
 *  https://salesforce.stackexchange.com/questions/158547/recurring-holidays-exclude-holidays-between-two-dates
 */

public inherited sharing class HolidayUtil {

  public static List<Holiday> holidays {
    get {
      // lazy load these
      if (holidays == null) {
        holidays = [
          SELECT ActivityDate, Description, IsAllDay, IsRecurrence, Name, 
                EndTimeInMinutes, StartTimeInMinutes, 
                RecurrenceDayOfMonth, RecurrenceDayOfWeekMask,
                RecurrenceEndDateOnly, RecurrenceInstance,
                RecurrenceInterval, RecurrenceMonthOfYear,
                RecurrenceStartDate, RecurrenceType 
          FROM Holiday 
          WHERE IsRecurrence = true OR ActivityDate = THIS_YEAR
        ];
      }
      return holidays;
    }
    private set;
  }

  public static final Map<Integer, Integer> dayByBitmask = new Map<Integer, Integer>{
    1 => 1, // sunday
    2 => 2, // monday
    4 => 3, // tuesday
    8 => 4, // wednesday
    16 => 5, // thursday
    32 => 6, // friday
    64 => 7 // saturday
    // 127 = everyday
  };

  public static final Map<String, Integer> dayByName = new Map<String, Integer>{
    'Sunday' => 1,
    'Monday' => 2,
    'Tuesday' => 3,
    'Wednesday' => 4,
    'Thursday' => 5,
    'Friday' => 6,
    'Saturday' => 7
  };

  public static final Map<String, Integer> monthByName = new Map<String, Integer>{
    'January' => 1,
    'February' => 2,
    'March' => 3,
    'April' => 4,
    'May' => 5,
    'June' => 6,
    'July' => 7,
    'August' => 8,
    'September' => 9,
    'October' => 10,
    'November' => 11,
    'December' => 12
  };

  public static final Map<String, Integer> weekByName = new Map<String, Integer>{
    'First' => 1,
    'Second' => 2,
    'Third' => 3,
    'Fourth' => 4,
    'Fifth' => 5
  };

  public static Boolean isHoliday(Date aDate) {
    Map<Date, Holiday> result = getBetweenDates(aDate, aDate);
    if (result.size() > 0) {
      return true;
    }
    return false;
  }

  public static Boolean isHoliday(Datetime aDatetime) {
    return isHoliday(aDatetime.date());
  }

  public static Map<Date, Holiday> getBetweenDates(Datetime startDate, Datetime endDate) {
    return getBetweenDates(startDate.date(), endDate.date());
  }

  public static Map<Date, Holiday> getBetweenDates(Date startDate, Date endDate) {
    Map<Date, Holiday> results = new Map<Date, holiday>();
    List<Date> dates = new List<Date>();
    for (Holiday h : holidays) {
      switch on h.RecurrenceType {
        when 'RecursYearlyNth' {
          dates = getYearlyNth(h, startDate, endDate);
        }
        when 'RecursYearly' {
          dates = getYearly(h, startDate, endDate);
        }
        when 'RecursMonthlyNth' {
          dates = getMonthlyNth(h, startDate, endDate);
        }
        when 'RecursMonthly' {
          dates = getMonthly(h, startDate, endDate);
        }
        when 'RecursWeekly' {
          dates = getWeekly(h, startDate, endDate);
        }
        when 'RecursDaily' {
          dates = getDaily(h, startDate, endDate);
        }
      }
      for (Date d : dates) {
        results.put(d, h);
      }
    }
    return results;
  }

  // recurs on set days in a year, like Christmas, New Years 
  public static List<Date> getYearly(Holiday h, Date startDate, Date endDate) {
    List<Date> results = new List<Date>();
    for (Integer year : getYears(startDate, endDate)) {
      Integer month = monthByName.get(h.RecurrenceMonthOfYear);
      Date d = Date.newInstance(year, month, h.RecurrenceDayOfMonth);
      if (d >= startDate && d <= endDate) {
        results.add(d);
      }
    }
    return results;
  }

  // recurs on something like 2nd tuesday of march - Thanksgiving, MLK day, Columbus Day
  public static List<Date> getYearlyNth(Holiday h, Date startDate, Date endDate) {
    List<Date> results = new List<Date>();
    Integer day = dayByBitmask.get(h.RecurrenceDayOfWeekMask);
    Integer month = monthByName.get(h.RecurrenceMonthOfYear);
    for (Integer year : getYears(startDate, endDate)) {
      Date d;
      if (h.RecurrenceInstance == 'Last') {
        d = getLastXOfMonth(day, month, year);
      } else {
        Integer week = weekByName.get(h.RecurrenceInstance);
        d = getXDayOfMonth(week, day, Date.newInstance(year, month, 2));
      }
      if (d >= startDate && d <= endDate) {
        results.add(d);
      }
    }
    return results;
  }

  // recurs on set day of every month - something like 5th of every month
  public static List<Date> getMonthly(Holiday h, Date startDate, Date endDate) {
    List<Date> results = new List<Date>();
    for (Date d : getMonths(startDate, endDate)){
      Date da = Date.newInstance(d.year(), d.month(), h.RecurrenceDayOfMonth);
      if (da >= startDate && da <= endDate) {
        results.add(da);
      }
    }
    return results;
  }

  // recurs monthly - something like every second sunday
  public static List<Date> getMonthlyNth(Holiday h, Date startDate, Date endDate) {
    List<Date> results = new List<Date>();
    List<Date> months = getMonths(startDate, endDate);
    Integer day = dayByBitmask.get(h.RecurrenceDayOfWeekMask);
    Integer week = weekByName.get(h.RecurrenceInstance);
    for (Date month : months) {
      Date d;
      if (h.RecurrenceInstance == 'Last') {
        d = getLastXOfMonth(day, month.month(), month.year());
      } else {
        d = getXDayOfMonth(week, day, Date.newInstance(month.year(), month.month(), 1));
      }
      if (d >= startDate && d <= endDate) {
        results.add(d);
      }
    }
    return results;
  }

  // something like every sat, sun or tues
  public static List<Date> getWeekly(Holiday h, Date startDate, Date endDate) {
    List<Date> results = new List<Date>();
    Integer day = dayByBitmask.get(h.RecurrenceDayOfWeekMask);
    Datetime dt = Datetime.newInstance(startDate.year(), startdate.month(), startDate.day(), 0, 0, 0); // valueOf(startDate);
    while (dayByName.get(dt.format('EEEE')) != day) {
      dt = dt.addDays(1);
    }
    while (dt <= endDate) {
      if (dt >= startDate && dt <= endDate) {
        results.add(dt.date());
      }
      dt = dt.addDays(7);
    }
    return results;
  }

  // something like every 15 days from start
  public static List<Date> getDaily(Holiday h, Date startDate, Date endDate) {
    List<Date> results = new List<Date>();
    Integer remainder;
    Date dailyDate = startDate.addDays(-1);
    while (remainder != 0) {
      dailyDate = dailyDate.addDays(1);
      remainder = Math.mod(h.RecurrenceStartDate.daysBetween(dailyDate), h.RecurrenceInterval);
    }
    results.add(dailyDate);
    while (dailyDate <= endDate) {
      dailyDate = dailyDate.addDays(h.RecurrenceInterval);
      if (dailyDate >= startDate && dailyDate <= endDate) {
        results.add(dailyDate);
      }
    }
    return results;
  }

  private static Date getLastXOfMonth(Integer dayOfWeek, Integer month, Integer year) {
    Datetime lastMonthDate = Datetime.newInstance(year, month + 1, 0, 0, 0, 0);
    Integer day = dayByName.get(lastMonthDate.format('EEEE'));
    while (day != dayOfWeek) {
      lastMonthDate = lastMonthDate.addDays(-1);
      day = dayByName.get(lastMonthDate.format('EEEE'));
    }
    return lastMonthDate.date();
  }

  private static Date getXDayOfMonth(Integer week, Integer day, Date monthIn) {
    Datetime firstMonthDate = Datetime.newInstance(monthIn.year(), monthIn.month(), 0, 0, 0, 0);
    Integer dayName;
    while (dayName != day) {
      firstMonthDate = firstMonthDate.addDays(1);
      dayName = dayByName.get(firstMonthDate.format('EEEE'));
    }
    if (week == 1) {
      return firstMonthDate.date();
    } else {
      return firstMonthDate.addDays(7 * (week - 1)).date();
    }
  }

  private static List<Date> getMonths(Date startDate, Date endDate) {
    List<Date> months = new List<Date>();
    Date m = Date.newInstance(startDate.year(), startDate.month(), 1);
    months.add(m);
    if (startDate.month() != endDate.month() || startDate.year() != endDate.year()) {
      while (m.monthsBetween(endDate) != 0) {
        m = m.addMonths(1);
        months.add(m);
      }
    }
    return months;
  }

  private static List<Integer> getYears(Date startDate, Date endDate) {
    List<Integer> years = new List<Integer>();
    Integer y = startDate.year();
    years.add(y);
    if (startDate.year() != endDate.year()) {
      while (y != endDate.year()) {
        y = y + 1;
        years.add(y);
      }
    }
    return years;
  }

}