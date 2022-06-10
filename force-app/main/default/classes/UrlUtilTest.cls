@IsTest
public class UrlUtilTest {

  @IsTest
  static void testBase() {
    Test.startTest();
    String result = UrlUtil.getBase();
    Test.stopTest();
    System.assert(String.isNotBlank(result));
  }

  @IsTest
  static void testDomainName() {
    Test.startTest();
    String result = UrlUtil.getDomainName();
    Test.stopTest();
    System.assert(String.isNotBlank(result));
  }

  @IsTest
  static void testLightningBase() {
    Test.startTest();
    String result = UrlUtil.getLightningBase();
    Test.stopTest();
    System.assert(String.isNotBlank(result));
  }

  @IsTest
  static void testVisualforceBase() {
    Test.startTest();
    String result = UrlUtil.getVisualforceBase();
    Test.stopTest();
    System.assert(String.isNotBlank(result));
  }

  @IsTest
  static void testDocumentforceBase() {
    Test.startTest();
    String result = UrlUtil.getDocumentforceBase();
    Test.stopTest();
    System.assert(String.isNotBlank(result));
  }

  @IsTest
  static void testSiteUrl() {
    List<Site> sites = [SELECT Name FROM Site];
    Test.startTest();
    if (!sites.isEmpty()) {
      String result = UrlUtil.getSiteUrl(sites[0].Name);
      System.assert(String.isNotBlank(result));
    }

    String result = UrlUtil.getSiteUrl('fakeSite');
    System.assertEquals(null, result);
    Test.stopTest();
  }

}
