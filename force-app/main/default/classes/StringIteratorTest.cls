@IsTest
public class StringIteratorTest {

  private static Integer maxValue = 500;

  private static String getText(String delimiter) {
    String result = '';
    for (Integer i = 0; i <= maxValue; i++) {
      result += 'Test string ' + i;
      if (i != maxValue) {
        // dont add the delimiter to the very end of the string
        result += delimiter;
      }
    }
    return result;
  }

  @IsTest
  static void testNewLine() {
    String delimiter = '\n';
    Integer count = 0;
    Test.startTest();
    StringIterator it = new StringIterator(getText(delimiter));
    while (it.hasNext()) {
      String next = it.next();
      System.assertEquals('Test string ' + count, next);
      count++;
    }
    it.iterator();
    System.assertEquals(false, it.hasNext());
    Test.stopTest();
  }

  @IsTest
  static void testDelimiter() {
    String delimiter = '*';
    Integer count = 0;
    Test.startTest();
    StringIterator it = new StringIterator(getText(delimiter), delimiter);
    while (it.hasNext()) {
      String next = it.next();
      System.assertEquals('Test string ' + count, next);
      count++;
    }
    System.assertEquals(false, it.hasNext());
    Test.stopTest();
  }

}
