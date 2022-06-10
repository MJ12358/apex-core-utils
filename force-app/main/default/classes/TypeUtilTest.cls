@IsTest
public class TypeUtilTest {

  private static final Map<Object, Map<String, Object>> testMap = new Map<Object, Map<String, Object>>{
    null => new Map<String, Object>{
      'name' => null,
      'type' => null
    },
    new Account() => new Map<String, Object>{
      'name' => 'Account',
      'type' => Account.class
    },
    true => new Map<String, Object>{
      'name' => 'Boolean',
      'type' => Boolean.class
    },
    '0015f00000CG8zVAAT' => new Map<String, Object>{
      'name' => 'Id',
      'type' => Id.class
    },
    'test' => new Map<String, Object>{
      'name' => 'String',
      'type' => String.class
    },
    Blob.valueOf('test') => new Map<String, Object>{
      'name' => 'Blob',
      'type' => Blob.class
    },
    Date.today() => new Map<String, Object>{
      'name' => 'Date',
      'type' => Date.class
    },
    Datetime.now() => new Map<String, Object>{
      'name' => 'Datetime',
      'type' => Datetime.class
    },
    Time.newInstance(0,0,0,0) => new Map<String, Object>{
      'name' => 'Time',
      'type' => Time.class
    },
    1 => new Map<String, Object>{
      'name' => 'Integer',
      'type' => Integer.class
    },
    2147483647L => new Map<String, Object>{
      'name' => 'Long',
      'type' => Long.class
    },
    123.12 => new Map<String, Object>{
      'name' => 'Decimal',
      'type' => Decimal.class
    },
    // unable to distinguish between decimal and double
    // 123.123123123123123 => new Map<String, Object>{
    //   'name' => 'Double',
    //   'type' => Double.class
    // },
    new List<String>{'test'} => new Map<String, Object>{
      'name' => 'List',
      'type' => List<String>.class
    },
    new List<Object>{'test', 1} => new Map<String, Object>{
      'name' => 'List',
      'type' => List<Object>.class
    },
    new Map<String, String>{'test' => 'test'} => new Map<String, Object>{
      'name' => 'Map',
      'type' => Map<String, String>.class
    },
    new Map<Object, Object>{'test' => 1} => new Map<String, Object>{
      'name' => 'Map',
      'type' => Map<Object, Object>.class
    }
  };

	@IsTest
	static void testGetType() {
		Test.startTest();
    for (Object o : testMap.keySet()) {
      System.Type t = (System.Type)testMap.get(o).get('type');
      Object result = TypeUtil.get(o);
      System.assertEquals(t, result);
    }
		Test.stopTest();
	}

	@IsTest
	static void testGetTypeAsString() {
		Test.startTest();
    for (Object o : testMap.keySet()) {
      String s = (String)testMap.get(o).get('name');
      Object result = TypeUtil.getAsString(o);
      System.assertEquals(s, result);
    }
		Test.stopTest();
	}

}
