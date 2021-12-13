# apex-core-utils
Core utilites for [Apex](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dev_guide.htm).

This is a WIP.

## This package's highlights include the following:

-	### BooleanUtil
	Utility to convert a boolean to a string an vice versa (with negate and xor).

- ### CronBuilder
	Used to build cron strings easily via a fluent api.

-	###	CsvBuilder
	Allows easy creation of csv's.

-	###	DateUtil
	Utilities to convert dates to strings and vice versa, check business hours and check holidays.

-	### EmailUtil
	Utility to easily send emails.

-	### FileUtil
	Utilities to get file icons, file sizes and mimetypes.

-	###	HolidayUtil
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
	Influnced by Java's StringBuilder.

-	### StringInterator
	Generic iterator used with strings.

-	### UserUtil
	Utilities to work with users.

-	### XmlReader
	Reads xml streams.

# Usage

`BooleanUtil`

```apex
String result = BooleanUtil.toString(true);
System.assert('TRUE', result);
```