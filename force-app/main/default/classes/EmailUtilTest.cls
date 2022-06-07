@IsTest
public class EmailUtilTest {

  private static String subject = 'Testing';
  private static String message = 'This is a test.';
  private static String address = 'test@test.com';

  @IsTest
  static void testSend() {
    Test.startTest();
    EmailUtil.send(subject, message, address);
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
  static void testGetVisibleText() {
    String s1 = 'This is a test. From: Test <test@test.com> Should not be seen.';
    String s2 = 'This is a test. ----Original Message---- Should not be seen.';
    String s3 = 'This is a test. On wrote: Should not be seen.';
    String s4 = 'This is a test. <test@test.com> Should not be seen.';
    String s5 = 'This is a test. test@test.com wrote: Should not be seen.';
    Test.startTest();
    System.assertEquals(message, EmailUtil.getVisibleText(address, s1));
    System.assertEquals(message, EmailUtil.getVisibleText(address, s2));
    System.assertEquals(message, EmailUtil.getVisibleText(address, s3));
    System.assertEquals(message, EmailUtil.getVisibleText(address, s4));
    System.assertEquals(message, EmailUtil.getVisibleText(address, s5));
    Test.stopTest();
  }

}
