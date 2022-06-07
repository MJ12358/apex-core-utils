@IsTest
public class MergeFieldUtilTest {

  private static String template = 
    'Hi {!Name}, Welcome to Salesforce! Best, {!CreatedBy.Name} {!$User.Name}';
  private static String expectedOutput = 
    'Hi Test Company, Welcome to Salesforce! Best, Test User Test User';

  @TestSetup
  static void testSetup() {
    User usr = new User();
    usr.FirstName = 'Test';
    usr.LastName = 'User';
    usr.Alias = 'merge';
    usr.Email = 'mergefield@mergfield.com';
    usr.EmailEncodingKey = 'UTF-8';
    usr.LanguageLocaleKey = 'en_US';
    usr.LocaleSidKey = 'en_US';
    usr.TimeZoneSidKey = 'GMT';
    usr.ProfileId = System.UserInfo.getProfileId();
    usr.Username = usr.Email;
    insert usr;

    // run as this user so we can control the created by name
    System.runAs(usr) {
      Account acc = new Account();
      acc.Name = 'Test Company';
      insert acc;
    }
  }

  @IsTest
  static void testSuccess() {
    Account acc = [SELECT Id FROM Account LIMIT 1];
    User usr = [SELECT Id FROM User ORDER BY CreatedDate DESC LIMIT 1];
    Test.startTest();
    String result;
    // run as this user so we can control the 'current user'
    System.runAs(usr) {
      result = MergeFieldUtil.resolve(acc.Id, template);
    }
    Test.stopTest();
    System.assert(String.isNotBlank(result));
    System.assertEquals(expectedOutput, result);
  }

  @IsTest
  static void testError() {
    Account acc = [SELECT Id FROM Account LIMIT 1];
    Test.startTest();
    String result = MergeFieldUtil.resolve(acc, template);
    Test.stopTest();
    System.assert(String.isNotBlank(result));
    System.assertNotEquals(expectedOutput, result);
  }

}
