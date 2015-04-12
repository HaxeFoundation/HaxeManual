## 10.14.8 SQL functions

###### SQL global functions
The following SQL global functions are possible in search queries:

##### functions
 
 Function  | Haxe Type  | SQL Type  |  Description 
 --- | --- | --- | ---
<code>now()</code>  | <code>SDateTime</code>  | <code>SQL NOW()</code>  | returns the current datetime 
<code>curDate()</code>  | <code>SDate</code>  | <code>SQL CURDATE()</code>  | returns the current date 
<code>date(v:SDateTime)</code>  | <code>SDate</code>  | <code>SQL DATE()</code>  | returns the date part of the <code>DateTime</code> 
<code>seconds(v:Float)</code>  | <code>SInterval</code>  | <code>SQL INTERVAL v SECOND</code>  | returns the date interval in seconds  
<code>minutes(v:Float)</code>  | <code>SInterval</code>  | <code>SQL INTERVAL v MINUTE</code>  | returns the date interval in minutes 
<code>hours(v:Float)</code>  | <code>SInterval</code>  | <code>SQL INTERVAL v HOUR</code>  | returns the date interval in hours 
<code>days(v:Float)</code>  | <code>SInterval</code>  | <code>SQL INTERVAL v DAY</code>  | returns the date interval in days 
<code>months(v:Float)</code>  | <code>SInterval</code>  | <code>SQL INTERVAL v MONTH</code>  | returns the date interval in months 
<code>years(v:Float)</code>  | <code>SInterval</code>  | <code>SQL INTERVAL v YEAR</code>  | returns the date interval in years 

###### SQL global operations
The following SQL global operators are possible in search queries:

##### operators
 
 Search operator  | SQL operator  |  Description 
 --- | --- | ---
<code>stringA.like(stringB)</code>  | SQL LIKE  | find if <code>stringB</code> is contained into <code>stringA</code> 
<code>name in ["a", "b", "c"]</code>   |   | Pass any <code>Iterable</code> to the in operator. An empty iterable will emit a false statement to prevent SQL errors when doing <code>IN ()</code>.

---

Previous section: [SPOD Manager](std-spod-manager.md)

Next section: [Search options](std-spod-search-options.md)