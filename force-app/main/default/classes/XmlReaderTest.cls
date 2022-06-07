@IsTest
public class XmlReaderTest {

	private static String sample = 
    '<?xml version="1.0" encoding="UTF-8"?><note><to>Tove</to><from>Jani</from></note>';

	@IsTest
	static void testGetElement() {
		Test.startTest();
    XmlReader reader = new XmlReader(sample);
    reader.getElement('to');
		String result = reader.getResult();
		Test.stopTest();
    System.assert(String.isNotBlank(result));
		System.assertEquals('Tove', result);
	}

  @IsTest
	static void testGetElement2() {
		Test.startTest();
    XmlReader reader = new XmlReader(sample);
    reader.getElement('from');
		String result = reader.getResult();
		Test.stopTest();
    System.assert(String.isNotBlank(result));
		System.assertEquals('Jani', result);
	}

  // TODO: get a sample where you can test this
	// @IsTest
	// static void testGetAttribute() {
	// 	Test.startTest();
  //   XmlReader reader = new XmlReader(sample);
  //   reader.getAttribute('style', 'id');
	// 	String result = reader.getResult();
	// 	Test.stopTest();
	// 	System.assert(String.isNotBlank(result));
	// 	System.assertEquals('SouthMetroStyle', result);
	// }

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
