# apex-core-utils
Core utilites for [Apex](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dev_guide.htm).

<a href="https://githubsfdeploy.herokuapp.com/app/githubdeploy/MJ12358/apex-core-utils?ref=main">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

# Highlights

-	### BooleanUtil
	Utility to convert a boolean to a string and vice versa.

- ### CronBuilder
	Used to build cron strings easily via a fluent api.

-	###	CsvBuilder
	Allows easy creation of csv strings.

-	###	DateUtil
	Utilities to convert dates to strings and vice versa, check business hours and check holidays.

-	### EmailUtil
	Utility to easily send emails.

-	### FileUtil
	Utilities to get file icons, sizes, extensions and mimetypes.

-	###	HolidayUtil
    [Inspired by this awesome code](https://salesforce.stackexchange.com/questions/158547/recurring-holidays-exclude-holidays-between-two-dates)

	  Used to determine if a date is a holiday.

-	### IntegerIterator
    [Inspired by this post](https://salesforce.stackexchange.com/questions/116785/how-to-create-thousands-of-records-using-batch-apex)

	  Generic iterator used with integers.

-	### ListUtil
	Used to convert to and from lists of all types.

-	### MergeFieldUtil
	Allows conversion of merge fields within a string (similar to VisualForce).

-	### NumberUtil
	Utilities to work with numbers.

-	### StringBuilder
	  [Inspired by this amazing code](https://github.com/financialforcedev/df12-apex-enterprise-patterns/blob/master/df12/src/classes/StringBuilder.cls)

    A string builder similar to Java's.

-	### StringInterator
	Generic iterator used with strings.

- ### TypeUtil
  Get the type of an object.

-	### UrlUtil
	Utilities to work with urls.

-	### XmlReader
	Reads xml streams.

# Usage

`BooleanUtil`

```apex
// to a string
String result = BooleanUtil.toString(true);
System.assertEquals('TRUE', result);

// to yes or no
String result = BooleanUtil.toYesNo(false);
System.assertEquals('NO', result);

// from string
Boolean result = BooleanUtil.toBoolean('yes');
System.assertEquals(true, result);

// from integer/double/decimal
Boolean result = BooleanUtil.toBoolean(1);
System.assertEquals(true, result);
```

`CronBuilder`

```apex
CronBuilder builder = new CronBuilder();

builder
	.second(45)
	.minute(47)
	.hour(6)
	.month(1);

String result = builder.build();
System.assertEquals('45 47 6 ? 1 ?', result);
```
Or pass it a date or datetime.

```apex
CronBuilder builder = new CronBuilder();
Datetime dt = Datetime.newInstance();
builder.fromDate(dt);
```

`CsvBuilder`

```apex
CsvBuilder builder = new CsvBuilder();

builder
  .appendField('Column1', 'value1')
  .newRow()
  .appendField('Column1', 'value2');

String result = builder.build();
```

`DateUtil`

```apex
Datetime dt = Datetime.now();

// 'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\''
String iso = DateUtil.toIsoString(dt);
```

`EmailUtil`

```apex
EmailUtil.send('Subject', 'Message', 'test@test.com');

String body = 'See you there! On Fri, May 27 Test <test@test.com> wrote: This is a previous message.';
String result = EmailUtil.getVisibleText(body);
System.assertEquals('See you there!', result);
```

`FileUtil`

```apex
String size = FileUtil.sizeToString(0);
System.assertEquals('0 Bytes', size);

String size = FileUtil.sizeToString(2048);
System.assertEquals('2 KB', size);
```

`HolidayUtil`

```apex
Date newYears = Date.newinstance(2020, 1, 1);
Boolean result = HolidayUtil.isHoliday(newYears);

// assuming Jan 1 is a holiday in your org
System.assertEquals(true, result);

// retrieve all holidays between two dates
Map<Date, Holiday> result = HolidayUtil.getBetweenDates(Date.today(), Date.today().addYears(1));
```

`IntegerIterator`

```apex
IntegerIterator it = new IntegerIterator(500);
while (it.hasNext()) {
  Integer next = it.next();
}
```

`ListUtil`

```apex
List<String> myList = new List<String>{'one', 'two', 'three'};
List<List<String>> result = ListUtil.chunk(myList, 2);
System.assertEquals(2, result.size());

List<String> result = ListUtil.reverse(myList);
System.assertEquals(new List<String>{'three', 'two', 'one'}, result);
```

`MergeFieldUtil`

```apex
Account acc = new Account();
acc.Name = 'Test Company';

String template = 'Hi {!Name}. Im {!$User.Name}';
String result = MergeFieldUtil.resolve(acc, template);
System.assertEquals('Hi Test Company. Im MJ12358);
```

`NumberUtil`

```apex
String result = NumberUtil.getOrdinal(223);
System.assertEquals('223rd', result);

Integer result = NumberUtil.hexToInt('abc');
System.assertEquals(2748, result);

String result = NumberUtil.intToHex(2748);
System.assertEquals('ABC', result);
```

`StringBuilder`

```apex
StringBuilder builder = new StringBuilder();

builder
  .separator(' ')
  .add('a')
  .add(new List<String>{'b', 'c'});

String result = builder.toString();
System.assertEquals('a b c', result);

// you can also pass it a field set or a list of SObjectField
StringBuilder.FieldListBuilder builder = new StringBuilder.FieldListBuilder(Account.SObjectType);

String result = builder.toString();
System.assertEquals('All,Your,Account,Fields', result);
```

`StringIterator`

```apex
String value = 'Test1,Test2,Test3';
StringIterator it = new StringIterator(value);
while (it.hasNext()) {
  String next = it.next();
}
```

`StringUtil`

```apex
String word1 = 'Account';
String word2 = 'Contact';
String result1 = StringUtil.getIndefiniteArticle(word1);
String result2 = StringUtil.getIndefiniteArticle(word2);
System.assertEquals('an', result1);
System.assertEquals('a', result2);

// great for when a third party api utilizes an apex reserved word
String json = '{"abstract": "value", "decimal": "value"};
String result = StringUtil.normalizeKeys(json);
System.assertEquals('{"abstractx": "value", "decimalx": "value"});
```

`TypeUtil`

```apex
System.Type t = TypeUtil.get('testing');
System.assertEquals(String.class, t);
System.Type t = TypeUtil.get(256);
System.assertEquals(Integer.class, t);

String s = TypeUtil.getAsString(256);
System.assertEquals('Integer', s);
```

# Tests

Current test results:

| Class | Percent | Lines |
| ----- | ------- | ----- |
| BooleanUtil | 100% | 31/31 |
| CronBuilder | 85% | 166/195 |
| CsvBuilder | 97% | 45/46 |
| DateUtil | 91% | 234/257 |
| EmailUtil | 62% | 44/70 |
| FileUtil | 84% | 146/173 |
| HolidayUtil | 71% | 119/167 |
| IntegerIterator | 75% | 18/24 |
| ListUtil | 92% | 445/482 |
| MergeFieldUtil | 80% | 54/67 |
| NumberUtil | 95% | 83/87 |
| StringBuilder | 81% | 49/60 |
| StringIterator | 100% | 18/18 |
| StringUtil | 94% | 143/151 |
| TypeUtil | 93% | 44/47 |
| UrlUtil | 63% | 41/65 |
| XmlReader | 100% | 31/31 |