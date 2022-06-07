@IsTest
public class EmailUtilTest {

  private static String subject = 'Testing';
  private static String message = 'This is a test';
  private static String toAddress = 'test@test.com';

  @IsTest
  static void testSend() {
    Test.startTest();
    EmailUtil.send(subject, message, toAddress);
    Test.stopTest();
  }

	@IsTest
	static void testDebug() {
		Test.startTest();
		EmailUtil.sendDebug(message);
		Test.stopTest();
	}

	@IsTest
	static void testInfo() {
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
