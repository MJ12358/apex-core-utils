# apex-core-utils
Core utilites for [Apex](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dev_guide.htm).

<a href="https://githubsfdeploy.herokuapp.com/app/githubdeploy/MJ12358/apex-core-utils?ref=main">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

## This package's highlights include the following:

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
	Generic iterator used with integers.

-	### ListUtil
	Used to convert to and from lists of all types.

-	### MergeFieldUtil
	Allows conversion of merge fields within a string (similar to VisualForce).

-	### NumberUtil
	Utilities to work with numbers.

-	### StringBuilder
	[Inspired by this amazing code](https://github.com/financialforcedev/df12-apex-enterprise-patterns/blob/master/df12/src/classes/StringBuilder.cls)

-	### StringInterator
	Generic iterator used with strings.

-	### UserUtil
	Utilities to work with users.

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
System.assertEquals(result, '45 47 6 ? 1 ?');
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
	.
```

# Tests

Current test results are as follows:

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
| UserUtil | 96% | 25/26 |
| XmlReader | 73% | 22/30 |