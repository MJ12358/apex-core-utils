@IsTest
public class IntegerIteratorTest {

	private static Integer maxValue = 500;

	@IsTest
	static void testNext() {
		Integer count = 0;
		Test.startTest();
		IntegerIterator it = new IntegerIterator(maxValue);
		while (it.hasNext()) {
			Integer next = it.next();
			System.assertEquals(count, next);
			count++;
		}
		System.assertEquals(false, it.hasNext());
		System.assertEquals(true, it.hasPrevious());
		it.iterator();
		Test.stopTest();
	}

	@IsTest
	static void testPrevious() {
		Integer count = maxValue;
		Test.startTest();
		IntegerIterator it = new IntegerIterator(maxValue);
		// go to the end first
		while (it.hasNext()) {
			it.next();
		}
		// then check for previous
		while (it.hasPrevious()) {
			Integer previous = it.previous();
			System.assertEquals(count, previous);
			count--;
		}
		System.assertEquals(true, it.hasNext());
		System.assertEquals(false, it.hasPrevious());
		Test.stopTest();
	}

}
