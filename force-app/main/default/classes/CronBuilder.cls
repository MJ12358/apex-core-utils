/**
 * Created on Thur Oct 31 2019
 *
 * Copyright (c) 2019 MJ12358
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

// TODO: possibly allow an "Object" to be passed
//  just to allow for greater flexibility
//   eg. passed a long or string data type

public inherited sharing class CronBuilder {

  //* {Seconds} {Minutes} {Hours} {Day_of_month} {Month} {Day_of_week} {Optional_year}

  /**
    * Name          Values    Special Chars
    * Seconds       0-59      None
    * Minutes       0-59      None
    * Hours         0-23      None
    * Day_of_Month  1-31      , - * ? / L W
    * Month         1-12      , - * /
    * Day_of_Week   1-7       , - * ? / L #
    * Optional_year 1970-2099 , - * /
    */

  /**
    * , Delimits values
    * - Range
    * * All values
    * ? No specfic value
    * / Increments (1/5 runs every 5th day of the month starting on the 1st)
    * L The end of a range (last)
    * W Nearest weekday of given day (20W)
    * # Nth day of the month (weekday#day_of_month)
    * Tip: Use L and W together to specify the last weekday of the month
    */

  private Object second = '0';
  private Object minute = '0';
  private Object hour = '0';
  private Object dayOfMonth = '?';
  private Object month = '*';
  private Object dayOfWeek = '?';
  private Object year = '';

  public CronBuilder second(Integer value) {
    validateSeconds(value);
    this.second = value;
    return this;
  }

  public CronBuilder minute(Integer value) {
    validateMinutes(value);
    this.minute = value;
    return this;
  }

  public CronBuilder hour(Integer value) {
    validateHours(value);
    this.hour = value;
    return this;
  }

  //* Day Of Month

  public CronBuilder dayOfMonth(Integer value) {
    validateDay(value);
    this.dayOfMonth = value;
    return this;
  }

  public CronBuilder dayOfMonth(Integer start, Integer stop) {
    validateDay(start, stop);
    this.dayOfMonth = String.valueOf(start) + '-' + String.valueOf(stop);
    return this;
  }

  public CronBuilder everyNthDayOfMonth(Integer start, Integer dayOfMonth) {
    validateDay(start);
    validateDay(dayOfMonth);
    this.dayOfMonth = String.valueOf(start) + '/' + String.valueOf(dayOfMonth);
    return this;
  }

  public CronBuilder lastDayOfMonth() {
    this.dayOfMonth = 'L';
    return this;
  }

  public CronBuilder nearestWeekday(Integer value) {
    validateDay(value);
    this.dayOfMonth = String.valueOf(value) + 'W';
    return this;
  }

  //* Month

  public CronBuilder month(Integer value) {
    validateMonth(value);
    this.month = value;
    return this;
  }

  public CronBuilder month(Integer start, Integer stop) {
    validateMonth(start, stop);
    this.month = String.valueOf(start) + '-' + String.valueOf(stop);
    return this;
  }

  public CronBuilder month(Month value) {
    this.month = value.name();
    return this;
  }

  public CronBuilder month(Month start, Month stop) {
    this.month = start.name() + '-' + stop.name();
    return this;
  }

  //* Day Of Week

  public CronBuilder dayOfWeek(Integer value) {
    validateDayOfWeek(value);
    this.dayOfWeek = value;
    return this;
  }

  public CronBuilder dayOfWeek(Integer start, Integer stop) {
    validateDayOfWeek(start, stop);
    this.dayOfWeek = String.valueOf(start) + '-' + String.valueOf(stop);
    return this;
  }

  public CronBuilder dayOfWeek(Day value) {
    this.dayOfWeek = value.name();
    return this;
  }

  public CronBuilder dayOfWeek(Day start, Day stop) {
    this.dayOfWeek = start.name() + '-' + stop.name();
    return this;
  }

  public CronBuilder lastDayOfWeek() {
    this.dayOfWeek = 'L';
    return this;
  }

  public CronBuilder nthWeekday(Integer weekDay, Integer dayOfMonth) {
    validateDayOfWeek(weekDay);
    validateDay(dayOfMonth);
    this.dayOfWeek = String.valueOf(weekDay) + '#' + String.valueOf(dayOfMonth);
    return this;
  }

  //* Optional Year

  public CronBuilder year(Integer value) {
    validateYear(value);
    this.year = value;
    return this;
  }

  public CronBuilder year(Integer start, Integer stop) {
    validateYear(start, stop);
    this.year = String.valueOf(start) + '-' + String.valueOf(stop);
    return this;
  }

  //* Utility Methods

  public CronBuilder everyHour() {
    return everyHour(0);
  }

  public CronBuilder everyHour(Integer minute) {
    validateMinutes(minute);
    this.second = 0;
    this.minute = minute;
    this.hour = '*';
    this.dayOfMonth = '*';
    this.month = '*';
    return this;
  }

  public CronBuilder everyDay() {
    return everyDay(0);
  }

  public CronBuilder everyDay(Integer hour) {
    validateHours(hour);
    this.second = 0;
    this.minute = 0;
    this.hour = hour;
    this.dayOfMonth = '*';
    this.month = '*';
    return this;
  }

  public CronBuilder everyMonth() {
    return everyMonth(1);
  }

  public CronBuilder everyMonth(Integer day) {
    validateDay(day);
    this.second = 0;
    this.minute = 0;
    this.hour = 0;
    this.dayOfMonth = day;
    this.month = '*';
    return this;
  }

  public CronBuilder everyYear() {
    return everyYear(1);
  }

  public CronBuilder everyYear(Integer month) {
    validateMonth(month);
    this.second = 0;
    this.minute = 0;
    this.hour = 0;
    this.dayOfMonth = 1;
    this.month = month;
    this.year = '*';
    return this;
  }

  public CronBuilder fromDate(Date d) {
    Datetime dt = Datetime.newInstance(d.year(), d.month(), d.day());
    return fromDate(dt);
  }

  public CronBuilder fromDate(Datetime dt) {
    this.second = dt.second();
    this.minute = dt.minute();
    this.hour = dt.hour();
    this.dayOfMonth = dt.day();
    this.month = dt.month();
    this.year = dt.year();
    return this;
  }

  //* Build

  public String build() {
    checkLimits();
    return String.format('{0} {1} {2} {3} {4} {5} {6}',
      new List<Object>{
        this.second,
        this.minute,
        this.hour,
        this.dayOfMonth,
        this.month,
        (this.dayOfWeek == '?' && this.dayOfMonth == '?') ? '*' : this.dayOfWeek, // they both cannot be '?'
        this.year
      }
    ).trim();
  }

  //* Validation methods

  private void validateSeconds(Integer value) {
    if (value < 0 || value > 59) {
      throw new CronBuilderException(System.Label.CronSecondInvalid);
    }
  }

  private void validateMinutes(Integer value) {
    if (value < 0 || value > 59) {
      throw new CronBuilderException(System.Label.CronMinuteInvalid);
    }
  }

  private void validateHours(Integer value) {
    if (value < 0 || value > 23) {
      throw new CronBuilderException(System.Label.CronHourInvalid);
    }
  }

  // day

  private void validateDay(Integer value) {
    if (value < 1 || value > 31) {
      throw new CronBuilderException(System.Label.CronDayOfMonthInvalid);
    }
  }

  private void validateDay(Integer start, Integer stop) {
    validateDay(start);
    validateDay(stop);
    if (start > stop) {
      throw new CronBuilderException(System.Label.CronDayOfMonthStartStopInvalid);
    }
  }

  // month

  private void validateMonth(Integer value) {
    if (value < 1 || value > 12) {
      throw new CronBuilderException(System.Label.CronMonthInvalid);
    }
  }

  private void validateMonth(Integer start, Integer stop) {
    validateMonth(start);
    validateMonth(stop);
    if (start > stop) {
      throw new CronBuilderException(System.Label.CronMonthStartStopInvalid);
    }
  }

  // day of week

  private void validateDayOfWeek(Integer value) {
    if (value < 1 || value > 7) {
      throw new CronBuilderException(System.Label.CronDayOfWeekInvalid);
    }
  }

  private void validateDayOfWeek(Integer start, Integer stop) {
    validateDayOfWeek(start);
    validateDayOfWeek(stop);
    if (start > stop) {
      throw new CronBuilderException(System.Label.CronDayOfWeekStartStopInvalid);
    }
  }

  // year

  private void validateYear(Integer value) {
    if (value < 1970 || value > 2099) {
      throw new CronBuilderException(System.Label.CronYearInvalid);
    }
  }

  private void validateYear(Integer start, Integer stop) {
    validateYear(start);
    validateYear(stop);
    if (start > stop) {
      throw new CronBuilderException(System.Label.CronYearStartStopInvalid);
    }
  }

  //* Utilities

  private void checkLimits() {
    if (System.Limits.getDmlStatements() >= System.Limits.getLimitDmlStatements()) {
      throw new CronBuilderException(System.Label.DmlLimitReached);
    }
    if (System.Limits.getSoslQueries() >= System.Limits.getLimitSoslQueries()) {
      throw new CronBuilderException(System.Label.SoqlLimitReached);
    }
    if ([SELECT Count() FROM CronTrigger] >= 100) {
      throw new CronBuilderException(System.Label.CronLimitReached);
    }
  }

  //* Enums

  public enum Day {
    SUN,
    MON,
    TUE,
    WED,
    THU,
    FRI,
    SAT
  }

  public enum Month {
    JAN,
    FEB,
    MAR,
    APR,
    MAY,
    JUN,
    JUL,
    AUG,
    SEP,
    OCT,
    NOV,
    DEC
  }

}
