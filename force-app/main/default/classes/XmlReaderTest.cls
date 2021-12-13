@IsTest
public class XmlReaderTest {

	private static StaticResource sample;

	static {
		sample = [SELECT Body FROM StaticResource WHERE Name = 'KML_Sample' LIMIT 1];
	}

	@IsTest
	static void testGetElement() {
		Test.startTest();
		String result = new XmlReader(sample.body.toString()).getElement('coordinates').getResult();
		Test.stopTest();
		System.assert(String.isNotBlank(result));
	}

	@IsTest
	static void testGetAttribute() {
		Test.startTest();
		String result = new XmlReader(sample.body.toString()).getAttribute('style', 'id').getResult();
		Test.stopTest();
		System.assert(String.isNotBlank(result));
		System.assertEquals('SouthMetroStyle', result);
	}

	@IsTest
	static void testComplex() {
		Dom.Document doc = new Dom.Document();
		doc.load(sample.body.toString());
		Test.startTest();
		XmlStreamReader result = new XmlReader(doc).setNamespace('testns').getReader();
		Test.stopTest();
		System.assertNotEquals(null, result);
	}

}
