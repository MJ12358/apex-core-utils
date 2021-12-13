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
		System.assertEquals(false, BooleanUtil.toBoolean(0));
		System.assertEquals(false, BooleanUtil.toBoolean(null));
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

	@IsTest
	static void testXor() {
		List<Boolean> bList = new List<Boolean>{ true, false, true, false };
		System.assert(false, BooleanUtil.xor(bList));
	}

}
