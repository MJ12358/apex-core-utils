@IsTest
public class StringBuilderTest {

  @IsTest
  static void testStringBuilder1() {
    StringBuilder sb = new StringBuilder();
    sb.add('this is a string');
    sb.add(new List<String>{', which is made',' up from\r ','a number of smaller strings', '. 5 in this case!'});
    System.assertEquals('this is a string, which is made up from\r a number of smaller strings. 5 in this case!', sb.toString()); 
  }

  @IsTest
  static void testStringBuilder2() {
    StringBuilder sb = new StringBuilder(new List<String>{'apples',' and ','pears',': stairs. '});
    sb.add('this is a string');
    sb.add(new List<String>{', which is made',' up from\r ','a number of smaller strings', '. 5 in this case!'});
    System.assertEquals('apples and pears: stairs. this is a string, which is made up from\r a number of smaller strings. 5 in this case!', sb.toString()); 
  }

  @IsTest
  static void testCommaDelimitedListBuilder1() {
    StringBuilder.CommaDelimitedListBuilder sb = new StringBuilder.CommaDelimitedListBuilder();
    sb.add('a');
    sb.add(new List<String>{'b','c','d'});
    System.assertEquals('a,b,c,d', sb.toString());  
  }

  @IsTest
  static void testCommaDelimitedListBuilder2() {
    StringBuilder.CommaDelimitedListBuilder sb = new StringBuilder.CommaDelimitedListBuilder(new List<String>{'x','y'});
    sb.add('a');
    sb.add(new List<String>{'b','c','d'});
    System.assertEquals('x,y,a,b,c,d', sb.toString());  
  }

  @IsTest
  static void testCommaDelimitedListBuilder3() {
    StringBuilder.CommaDelimitedListBuilder sb = new StringBuilder.CommaDelimitedListBuilder(new List<String>{'x','y'});
    sb.add('a');
    sb.add(new List<String>{'b','c','d'});
    System.assertEquals('$x,$y,$a,$b,$c,$d', sb.toString('$'));
  }

  @IsTest
  static void testFieldListBuilder() {
    List<Schema.SObjectField> fieldList = new List<Schema.SObjectField>{
      Account.Name,
      Account.BillingCity,
      Account.BillingCountry
    };
    StringBuilder.FieldListBuilder sb = new StringBuilder.FieldListBuilder(fieldList);
    System.assertEquals('Name,BillingCity,BillingCountry', sb.toString());
  }

  @IsTest
  static void testFieldListBuilder2() {
    StringBuilder.FieldListBuilder sb = new StringBuilder.FieldListBuilder(Account.SObjectType);
    System.assert(String.isNotBlank(sb.toString()));
  }

}
