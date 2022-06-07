@IsTest
public class ListUtilTest {

	private static Integer count = 5;
	private static final Set<Blob> blobSet = new Set<Blob>{
		Blob.valueOf('1'),
		Blob.valueOf('2'),
		Blob.valueOf('3'),
		Blob.valueOf('4'),
		Blob.valueOf('5')
	};
	private static final Set<Boolean> booleanSet = new Set<Boolean>{
		true,
		false,
		false,
		true,
		true
	};
	private static final Set<Date> dateSet = new Set<Date>{
		Date.today(),
		Date.today().addDays(1),
		Date.today().addDays(2),
		Date.today().addDays(3),
		Date.today().addDays(4)
	};
	private static final Set<Datetime> datetimeSet = new Set<Datetime>{
		Datetime.now(),
		Datetime.now().addDays(1),
		Datetime.now().addDays(2),
		Datetime.now().addDays(3),
		Datetime.now().addDays(4)
	};
	private static final Set<Decimal> decimalSet = new Set<Decimal>{
		0,
		1.1,
		2.2,
		3.3,
		4.4
	};
	private static final Set<Double> doubleSet = new Set<Double>{
		0,
		1.1,
		2.2,
		3.3,
		4.4
	};
	private static final Set<Id> idSet {
		get {
			if (idSet == null) {
				idSet = new Set<Id>();
				for (SObject sObj : sObjectList) {
					idSet.add(sObj.Id);
				}
			}
			return idSet;
		}
		private set;
	}
	private static final Set<Integer> integerSet = new Set<Integer>{
		0,
		1,
		2,
		3,
		4
	};
	private static final Set<Long> longSet = new Set<Long>{
		123456780,
		123456781,
		123456782,
		123456783,
		123456784
	};
	private static final Set<Time> timeSet = new Set<Time>{
		Datetime.now().time(),
		Datetime.now().time().addHours(1),
		Datetime.now().time().addHours(2),
		Datetime.now().time().addHours(3),
		Datetime.now().time().addHours(4)
	};
	private static final Set<String> stringSet = new Set<String>{
		'one',
		'two',
		'three',
		'four',
		'five'
	};
	private static final List<SObject> sObjectList {
		get {
			if (sObjectList == null) {
				sObjectList = [SELECT Id, Name FROM Account];
			}
			return sObjectList;
		}
		private set;
	}

	@TestSetup
	static void testSetup() {
    List<Account> accounts = new List<Account>();
    for (Integer i = 0; i < count; i++) {
      Account acc = new Account();
      acc.Name = 'Test0';
      accounts.add(acc);
    }
    insert accounts;
	}

	@IsTest
	static void testChunk() {
		Set<String> items = new Set<String>(stringSet);
		Test.startTest();
		List<List<String>> results = ListUtil.chunk(items, 2);
		Test.stopTest();
		System.assertEquals(3, results.size());
	}

	@IsTest
	static void testToLowerCase() {
		Set<String> items = new Set<String>();
		items.add('test');
		items.add('Test');
		items.add('TEsT');
		Test.startTest();
		Set<String> results = ListUtil.toLowerCase(items);
		Test.stopTest();
		// sets are case sensitive
		System.assertEquals(1, results.size());
		for (String s : results) {
			System.assertEquals('test', s);
		}
	}

	@IsTest
	static void testToUpperCase() {
		Set<String> items = new Set<String>();
		items.add('test');
		items.add('Test');
		items.add('TEsT');
		Test.startTest();
		Set<String> results = ListUtil.toUpperCase(items);
		Test.stopTest();
		// sets are case sensitive
		System.assertEquals(1, results.size());
		for (String s : results) {
			System.assertEquals('TEST', s);
		}
	}

	@IsTest
	static void testPluck() {
		Test.startTest();
		List<Object> results = ListUtil.pluck(sObjectList, Account.Name);
		Test.stopTest();
		System.assertEquals(count, results.size());
		for (Object name : results) {
			System.assertNotEquals(null, name);
		}
	}

	@IsTest
	static void testReverse() {
		Test.startTest();
		Set<Blob> blobResult = ListUtil.reverse(blobSet);
		Set<Boolean> booleanResult = ListUtil.reverse(booleanSet);
		Set<Date> dateResult = ListUtil.reverse(dateSet);
		Set<Datetime> datetimeResult = ListUtil.reverse(datetimeSet);
		Set<Decimal> decimalResult = ListUtil.reverse(decimalSet);
		Set<Double> doubleResult = ListUtil.reverse(doubleSet);
		Set<Id> idResult = ListUtil.reverse(idSet);
		Set<Integer> integerResult = ListUtil.reverse(integerSet);
		Set<Long> longResult = ListUtil.reverse(longSet);
		Set<Time> timeResult = ListUtil.reverse(timeSet);
		Set<String> stringResult = ListUtil.reverse(stringSet);
		List<SObject> sObjectResult = ListUtil.reverse(sObjectList);
		Test.stopTest();
		System.assertEquals(new Set<Integer>{ 4, 3, 2, 1, 0 }, integerResult);
		System.assertEquals(new Set<String>{ 'five', 'four', 'three', 'two', 'one' }, stringResult);
	}

	@IsTest
	static void testSort() {
		Test.startTest();
		Set<Boolean> booleanResult = ListUtil.sort(booleanSet);
		Set<Date> dateResult = ListUtil.sort(dateSet);
		Set<Datetime> datetimeResult = ListUtil.sort(datetimeSet);
		Set<Decimal> decimalResult = ListUtil.sort(decimalSet);
		Set<Double> doubleResult = ListUtil.sort(doubleSet);
		Set<Id> idResult = ListUtil.sort(idSet);
		Set<Integer> integerResult = ListUtil.sort(integerSet);
		Set<Long> longResult = ListUtil.sort(longSet);
		Set<Time> timeResult = ListUtil.sort(timeSet);
		Set<String> stringResult = ListUtil.sort(stringSet);
		Test.stopTest();
	}

	@IsTest
	static void testUnique() {
		Test.startTest();
		Set<Blob> blobResult = ListUtil.unique(blobSet);
		Set<Boolean> booleanResult = ListUtil.unique(booleanSet);
		Set<Date> dateResult = ListUtil.unique(dateSet);
		Set<Datetime> datetimeResult = ListUtil.unique(datetimeSet);
		Set<Decimal> decimalResult = ListUtil.unique(decimalSet);
		Set<Double> doubleResult = ListUtil.unique(doubleSet);
		Set<Id> idResult = ListUtil.unique(idSet);
		Set<Integer> integerResult = ListUtil.unique(integerSet);
		Set<Long> longResult = ListUtil.unique(longSet);
		Set<Time> timeResult = ListUtil.unique(timeSet);
		Set<String> stringResult = ListUtil.unique(stringSet);
		List<SObject> sObjectResult = ListUtil.unique(sObjectList);
		Test.stopTest();
		System.assertEquals(integerSet, integerResult);
		System.assertEquals(stringSet, stringResult);
	}

	@IsTest
	static void testTrim() {
		Set<String> items = new Set<String>();
		items.add('test ');
		items.add(' test ');
		items.add(' test');
		Test.startTest();
		Set<String> results = ListUtil.trim(items);
		Test.stopTest();
		for (String s : results) {
			System.assertEquals('test', s);
		}
	}

	@IsTest
	static void testLeft() {
		Test.startTest();
		Set<String> results = ListUtil.left(stringSet, 2);
		Test.stopTest();
		System.assertEquals(new Set<String>{ 'on', 'tw', 'th', 'fo', 'fi' }, results);
	}

	@IsTest
	static void testMid() {
		Test.startTest();
		Set<String> results = ListUtil.mid(stringSet, 1, 2);
		Test.stopTest();
		System.assertEquals(new Set<String>{ 'ne', 'wo', 'hr', 'ou', 'iv' }, results);
	}

	@IsTest
	static void testRight() {
		Test.startTest();
		Set<String> results = ListUtil.right(stringSet, 2);
		Test.stopTest();
		System.assertEquals(new Set<String>{ 'ne', 'wo', 'ee', 'ur', 've' }, results);
	}

}
