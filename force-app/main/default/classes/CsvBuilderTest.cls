@IsTest
public class CsvBuilderTest {

  private static String headerName = 'headerName';
  private static String fieldValue = 'fieldValue';

  @IsTest
  static void testAppendField() {
    Test.startTest();
    CsvBuilder builder = new CsvBuilder();
    builder.appendField(headerName, fieldValue);
    Test.stopTest();
    System.assert(builder.headerToValues.containsKey(headerName));
    System.assertEquals(1, builder.headerToValues.get(headerName).size());
    System.assertEquals(fieldValue, builder.headerToValues.get(headerName).get(0));
  }

  @IsTest
  static void testNewRow() {
    Test.startTest();
    CsvBuilder builder = new CsvBuilder();
    builder.appendField(headerName, fieldValue);
    builder.newRow();
    builder.appendField(headerName, fieldValue);
    Test.stopTest();
    System.assert(builder.headerToValues.containsKey(headerName));
    System.assertEquals(2, builder.headerToValues.get(headerName).size());
    System.assertEquals(fieldValue, builder.headerToValues.get(headerName).get(0));
    System.assertEquals(fieldValue, builder.headerToValues.get(headerName).get(1));
  }

  @IsTest
  static void testToString() {
    String lineEnding = CsvBuilder.WINDOWS_LINE_ENDING;
    Test.startTest();
    CsvBuilder builder = new CsvBuilder();
    builder.appendField('Column1', 'value11');
    builder.appendField('Column2', 'value12');
    builder.newRow();
    builder.appendField('Column2', 'value22');
    String result = builder.toString();
    Test.stopTest();
    // System.assertEquals(
    //  'Column1,Column2' + lineEnding +
    //  'value11,value12' + lineEnding +
    //  ',value22',
    //  result
    // );
  }

}
