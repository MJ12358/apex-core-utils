@IsTest
public class XmlReaderTest {

  private static String sample = 
    '<?xml version="1.0" encoding="UTF-8"?><note id="mynote"><to>Tove</to><from>Jani</from></note>';

  @IsTest
  static void testGetElement() {
    Test.startTest();
    XmlReader reader = new XmlReader(sample);
    reader.getElement('to');
    String result = reader.getResult();
    Test.stopTest();
    System.assertEquals('Tove', result);
  }

  @IsTest
  static void testGetElement2() {
    Test.startTest();
    XmlReader reader = new XmlReader(sample);
    reader.getElement('from');
    String result = reader.getResult();
    Test.stopTest();
    System.assertEquals('Jani', result);
  }

  @IsTest
  static void testGetAttribute() {
    Test.startTest();
    XmlReader reader = new XmlReader(sample);
    reader.getAttribute('note', 'id');
    String result = reader.getResult();
    Test.stopTest();
    System.assertEquals('mynote', result);
  }

  @IsTest
  static void testComplex() {
    Dom.Document doc = new Dom.Document();
    doc.load(sample);
    Test.startTest();
    XmlReader reader = new XmlReader(doc);
    reader.setNamespace('testns');
    Test.stopTest();
    System.assertNotEquals(null, reader.getReader());
  }

}
