@IsTest
public class NumberUtilTest {

	@IsTest
	static void testGenerateGuid() {
		System.assert(String.isNotBlank(NumberUtil.generateGuid()));
	}

	@IsTest
	static void testGenerateRandomNumber() {
		System.assertNotEquals(null, NumberUtil.generateRandomNumber(32));
	}

	@IsTest
	static void testHexToInt() {
		System.assertEquals(15, NumberUtil.hexToInt('f'));
		System.assertEquals(15, NumberUtil.hexToInt('F'));
		System.assertEquals(175, NumberUtil.hexToInt('af'));
		System.assertEquals(175, NumberUtil.hexToInt('AF'));
		System.assertEquals(2748, NumberUtil.hexToInt('abc'));
		System.assertEquals(2748, NumberUtil.hexToInt('ABC'));
		System.assertEquals(16777215, NumberUtil.hexToInt('ffffff'));
		System.assertEquals(16777215, NumberUtil.hexToInt('FFFFFF'));
	}

	@IsTest
	static void testIntToHex() {
		System.assertEquals('0', NumberUtil.intToHex(0));
		System.assertEquals('F', NumberUtil.intToHex(15));
		System.assertEquals('AF', NumberUtil.intToHex(175));
		System.assertEquals('ABC', NumberUtil.intToHex(2748));
		System.assertEquals('FFFFFF', NumberUtil.intToHex(16777215));
	}

	@IsTest
	static void testGetHaversineDistance() {
		Decimal lat1 = 44.7742185;
		Decimal lng1 = -93.2582726;
		Decimal lat2 = 44.776852;
		Decimal lng2 = -93.3113175;
		Decimal result = NumberUtil.getHaversineDistance(lat1, lng1, lat2, lng2);
		System.assertNotEquals(null, result);
		System.assertEquals(0, NumberUtil.getHaversineDistance(44.7, -93.3, 44.7, -93.3));
	}

	@IsTest
	static void testIsNaN() {
		Integer zero = 0;
		Decimal dec = 44.7742185;
		Double dob = 12.00;
		System.assertEquals(false, NumberUtil.isNaN(zero));
		System.assertEquals(false, NumberUtil.isNaN(dec));
		System.assertEquals(false, NumberUtil.isNaN(dob));
		System.assertEquals(true, NumberUtil.isNaN('test'));
		System.assertEquals(true, NumberUtil.isNaN(null));
	}

	@IsTest
	static void testGetMinMaxInt() {
		List<Integer> list1 = new List<Integer>{ 0, 1, 2, 3, 4, 5 };
		List<Integer> list2 = new List<Integer>{ 8, 42, 1, 23, 9 };
		System.assertEquals(0, NumberUtil.getMin(list1));
		System.assertEquals(1, NumberUtil.getMin(list2));
		System.assertEquals(5, NumberUtil.getMax(list1));
		System.assertEquals(42, NumberUtil.getMax(list2));
	}

	@IsTest
	static void testGetMinMaxDec() {
		List<Decimal> list1 = new List<Decimal>{ 0, 1.1, 2.2, 3.3, 4.4, 5.5 };
		List<Decimal> list2 = new List<Decimal>{ 8.45, 42.98, 1.1, 23, 9.0 };
		System.assertEquals(0, NumberUtil.getMin(list1));
		System.assertEquals(1.1, NumberUtil.getMin(list2));
		System.assertEquals(5.5, NumberUtil.getMax(list1));
		System.assertEquals(42.98, NumberUtil.getMax(list2));
	}

	@IsTest
	static void testGetOrdinal() {
		System.assertEquals('1st', NumberUtil.getOrdinal(1));
		System.assertEquals('2nd', NumberUtil.getOrdinal('2'));
		System.assertEquals('3rd', NumberUtil.getOrdinal(3));
		System.assertEquals('4th', NumberUtil.getOrdinal('4'));
		System.assertEquals('5th', NumberUtil.getOrdinal(5));
		System.assertEquals('6th', NumberUtil.getOrdinal('6'));
		System.assertEquals('7th', NumberUtil.getOrdinal(7));
		System.assertEquals('8th', NumberUtil.getOrdinal('8'));
		System.assertEquals('9th', NumberUtil.getOrdinal(9));
		System.assertEquals('10th', NumberUtil.getOrdinal('10'));
		System.assertEquals('223rd', NumberUtil.getOrdinal(223));
		System.assertEquals('1225th', NumberUtil.getOrdinal('1225'));
	}

}
