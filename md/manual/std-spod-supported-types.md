## 10.14.5 SPOD Supported types

##### Supported types
 
 Haxe Type  |  SQL Type   |  Description 
 --- | --- | ---
`Int`, <code>SInt</code>  | <code>SSQL</code> INT  | a classic 32 bits signed integer 
`Float`, <code>SFloat</code>  | <code>SQL DOUBLE</code>  | a double precision float value  
`Bool` <code>SBool</code>   | <code>SQL TINYINT(1)</code> or <code>BOOL</code>  | a boolean value 
`Date`, <code>SDateTime</code>   | <code>SQL DATETIME</code>  | a complete date value 
`SDate`   | <code>SQL DATE</code>  | a date-only value 
`SString<K>`   | <code>SQL VARCHAR(K)</code>  | a size-limited string value 
`String`, <code>SText</code>   | <code>SQL MEDIUMTEXT</code>  | a text up to 16 MB 
`SBytes<K>`   | <code>SQL BINARY(K)</code>  | a fixed-size bytes value 
`SBinary`, `haxe.io.Bytes`   | <code>SQL MEDIUMBLOB</code>  | up to 16 MB bytes 
`SId`   | <code>SQL INT AUTO INCREMENT</code>  | same as <code>SInt</code> but used as an unique ID with auto increment 
`SEnum<E>`   | <code>SQL TINYINT UNSIGNED</code>  | a single enum without parameters which index is stored as a small integer 
`SFlags<E>`   |   | a 32 bits flag that uses an enum as bit markers. See `haxe.EnumFlags` 
`SData<Anything>`   |    | allow arbitrary serialized data (see below) 
`Null<T>`, `SNull<T>`  |  | tells that this field can be <code>NULL</code> in the database 

###### Advanced Types

The following advanced types are also available to use specific storage size:

##### Supported advanced types
 
 Haxe Type  |  SQL Type   |  Description 
 --- | --- | ---
<code>SUInt</code>  | <code>SQL UNSIGNED INT</code>  | an unsigned 32 bits integer 
<code>STinyInt</code>, <code>STinyUInt</code>  | <code>SQL TINYINT</code>  | a small 8 bits signed/unsigned integer 
<code>SSmallInt</code>, <code>SSmallUInt</code>  | <code>SQL SMALLINT</code>  | a small 16 bits signed/unsigned integer 
<code>SMediumIInt</code>, <code>SMediumUInt</code>  | <code>SQL MEDIUMINT</code>  | a small 24 bits signed/unsigned integer 
<code>SBigInt</code>  | <code>SQL BIGINT</code>  | a 64 bits signed integer - typed as Float in Haxe 
<code>SSingle</code>  | <code>SQL FLOAT</code>  | a single precision float value 
<code>STinyText</code>  | <code>SQL TINYTEXT</code>  | a text up to 255 bytes 
<code>SSmallText</code>  | <code>SQL TEXT</code>  | a text up to 65KB 
<code>STimeStamp</code>  | <code>SQL TIMESTAMP</code>  | a 32-bits date timestamp 
<code>SSmallBinary</code>  | <code>SQL BLOB</code>  | up to 65 KB bytes 
<code>SLongBinary</code>  | <code>SQL LONGBLOB</code>  | up to 4GB bytes 
<code>SUId</code>  | <code>SQL INT UNSIGNED AUTO INCREMENT</code>  | same as <code>SUInt</code> but used as an unique ID with auto increment 
<code>SBigId</code>  | <code>SQL BIGINT AUTO INCREMENT</code>  | same as <code>SBigInt</code> but used as an unique ID with auto increment - compiled as `Float` in Haxe 
<code>SSmallFlags&lt;E&gt;</code>  |    | similar to <code>SFlags</code> except that the integer used to store the data is based on the number of flags allowed

---

Previous section: [Creating tables](std-spod-tables.md)

Next section: [SPOD Metadata](std-spod-metadata.md)