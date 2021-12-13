@IsTest
public class EmailUtilTest {

	@IsTest
	static void testDebug() {
		String message = 'This is only a test.';
		Test.startTest();
		try {
			EmailException e = new EmailException();
			e.setMessage('Test error message');
			throw e;
		} catch (Exception e) {
			EmailUtil.sendDebug(message);
		}
		Test.stopTest();
	}

	@IsTest
	static void testInfo() {
		String message = 'This is only a test.';
		Test.startTest();
		EmailUtil.sendInfo(message);
		Test.stopTest();
	}

	@IsTest
	static void testStripReplies() {
		String address = 'test@test.com';
		String result = 'This is a test.';
		String s1 = 'This is a test. From: Test <test@test.com> Should not be seen.';
		String s2 = 'This is a test. ----Original Message---- Should not be seen.';
		String s3 = 'This is a test. On wrote: Should not be seen.';
		String s4 = 'This is a test. <test@test.com> Should not be seen.';
		String s5 = 'This is a test. test@test.com wrote: Should not be seen.';
		Test.startTest();
		System.assertEquals(result, EmailUtil.stripReplies(address, s1));
		System.assertEquals(result, EmailUtil.stripReplies(address, s2));
		System.assertEquals(result, EmailUtil.stripReplies(address, s3));
		System.assertEquals(result, EmailUtil.stripReplies(address, s4));
		System.assertEquals(result, EmailUtil.stripReplies(address, s5));
		Test.stopTest();
	}

}
