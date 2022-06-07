@IsTest
public class BooleanUtilTest {

	@IsTest
	static void testNegate() {
		System.assertEquals(true, BooleanUtil.negate(false));
		System.assertEquals(false, BooleanUtil.negate(true));
		System.assertEquals(false, BooleanUtil.negate(null));
	}

	@IsTest
	static void testToBoolean() {
		System.assertEquals(true, BooleanUtil.toBoolean(1));
    System.assertEquals(true, BooleanUtil.toBoolean(1.123));
		System.assertEquals(false, BooleanUtil.toBoolean(0));
    System.assertEquals(false, BooleanUtil.toBoolean(0.123));
		System.assertEquals(false, BooleanUtil.toBoolean(null));
    System.assertEquals(true, BooleanUtil.toBoolean('true'));
    System.assertEquals(true, BooleanUtil.toBoolean('yes'));
    System.assertEquals(true, BooleanUtil.toBoolean('y'));
    System.assertEquals(false, BooleanUtil.toBoolean('test'));
    System.assertEquals(false, BooleanUtil.toBoolean(new List<String>()));
	}

	@IsTest
	static void testToYesNo() {
		System.assertEquals('YES', BooleanUtil.toYesNo(true));
		System.assertEquals('NO', BooleanUtil.toYesNo(false));
		System.assertEquals('NO', BooleanUtil.toYesNo(null));
		System.assertEquals('Y', BooleanUtil.toYN(true));
		System.assertEquals('N', BooleanUtil.toYN(false));
		System.assertEquals('N', BooleanUtil.toYN(null));
	}

	@IsTest
	static void testToString() {
		System.assertEquals('TRUE', BooleanUtil.toString(true));
		System.assertEquals('FALSE', BooleanUtil.toString(false));
		System.assertEquals('FALSE', BooleanUtil.toString(null));
	}

}
