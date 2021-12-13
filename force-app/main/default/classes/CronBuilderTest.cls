@IsTest
public class CronBuilderTest {

	@IsTest
	static void testEveryHour() {
		Test.startTest();
		String result = new CronBuilder().everyHour().build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		System.assertEquals('0 0 * * * ?', result);
		Test.stopTest();
	}

	//* Day

	@IsTest
	static void testEveryDay() {
		Test.startTest();
		String result = new CronBuilder().everyDay().build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		Test.stopTest();
		System.assertEquals('0 0 0 * * ?', result);
	}

	@IsTest
	static void testEveryDayAlt() {
		Test.startTest();
		String result = new CronBuilder().hour(13).build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		Test.stopTest();
		System.assertEquals('0 0 13 ? * *', result);
	}

	//* Day Of Month

	@IsTest
	static void testDayOfMonth() {
		Test.startTest();
		String result = new CronBuilder().dayOfMonth(1, 15).build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		Test.stopTest();
		System.assertEquals('0 0 0 1-15 * ?', result);
	}

	@IsTest
	static void testEveryNthDayOfMonth() {
		Test.startTest();
		String result = new CronBuilder().everyNthDayOfMonth(1, 15).build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		Test.stopTest();
		System.assertEquals('0 0 0 1/15 * ?', result);
	}

	@IsTest
	static void testLastDayOfMonth() {
		Test.startTest();
		String result = new CronBuilder().lastDayOfMonth().build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		Test.stopTest();
		System.assertEquals('0 0 0 L * ?', result);
	}

	@IsTest
	static void testNearestWeekday() {
		Test.startTest();
		String result = new CronBuilder().nearestWeekday(15).build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		Test.stopTest();
		System.assertEquals('0 0 0 15W * ?', result);
	}

	//* Month

	@IsTest
	static void testEveryMonth() {
		Test.startTest();
		String result = new CronBuilder().everyMonth().build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		Test.stopTest();
		System.assertEquals('0 0 0 1 * ?', result);
	}

	@IsTest
	static void testMonth() {
		Test.startTest();
		String result = new CronBuilder().month(1, 6).build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		Test.stopTest();
		System.assertEquals('0 0 0 ? 1-6 *', result);
	}

	//* Day Of Week

	@IsTest
	static void testDayOfWeek() {
		Test.startTest();
		String result = new CronBuilder().dayOfWeek(1, 5).build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		Test.stopTest();
		System.assertEquals('0 0 0 ? * 1-5', result);
	}

	@IsTest
	static void testLastDayOfWeek() {
		Test.startTest();
		String result = new CronBuilder().lastDayOfWeek().build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		Test.stopTest();
		System.assertEquals('0 0 0 ? * L', result);
	}

	@IsTest
	static void testNthWeekday() {
		Test.startTest();
		String result = new CronBuilder().nthWeekday(5, 5).build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		Test.stopTest();
		System.assertEquals('0 0 0 ? * 5#5', result);
	}

	//* Year

	@IsTest
	static void testEveryYear() {
		Test.startTest();
		String result = new CronBuilder().everyYear().build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		Test.stopTest();
		System.assertEquals('0 0 0 1 1 ? *', result);
	}

	@IsTest
	static void testYear() {
		Test.startTest();
		String result = new CronBuilder().year(2099).build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		Test.stopTest();
		System.assertEquals('0 0 0 ? * * 2099', result);
	}

	@IsTest
	static void testYearAlt() {
		Test.startTest();
		String result = new CronBuilder().year(2020, 2099).build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		Test.stopTest();
		System.assertEquals('0 0 0 ? * * 2020-2099', result);
	}

	//* Misc

	@IsTest
	static void testComplex() {
		Test.startTest();
		String result = new CronBuilder().second(30).minute(45).hour(15).dayOfMonth(15).month(7).year(2099).build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		Test.stopTest();
		System.assertEquals('30 45 15 15 7 ? 2099', result);
	}

	@IsTest
	static void testFromDate() {
		Test.startTest();
		Date dt = Date.newInstance(2099, 01, 01);
		String result = new CronBuilder().fromDate(dt).build();
		try {
			System.schedule('Test', result, new TestSchedule());
			System.assert(true, 'No exception occurred');
		} catch (Exception e) {
			System.assert(false, 'An exception occurred');
		}
		Test.stopTest();
		System.assertEquals('0 0 0 1 1 ? 2099', result);
	}

	@IsTest
	static void testError() {
		Test.startTest();
		try {
			CronBuilder result = new CronBuilder().second(61);
			System.assert(false, 'Excepted an exception');
		} catch (CronBuilderException e) {
			System.assert(true, 'Exception caught');
		}
		Test.stopTest();
	}

	private class TestSchedule implements Schedulable {
		public void execute(System.SchedulableContext ctx) {}
	}

}
