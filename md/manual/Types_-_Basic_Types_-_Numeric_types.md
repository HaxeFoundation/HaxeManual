While every `Int` can be used where a `Float` is expected (that is, `Int` **is assignable to** or **unifies with** `Float`), the reverse is not true: Assigning a `Float` to an `Int` might lose precision and is not implicitly allowed.






Operator & Operation 
 
`-` & negation 

`~` & bitwise negation 

`++` & incrementation 

`--` & decrementation 
 






 
 
Operator & Operation & Argument 1 & Argument 2 & Return 
 
`+` & addition & `Float` & `Float` & `Float` 

& & `Float` & `Int` & `Float` 

& & `Int` & `Float` & `Float` 

& & `Int` & `Int` & `Int` 

`-` & subtraction & `Float` & `Float` & `Float` 

& & `Float` & `Int` & `Float` 

& & `Int` & `Float` & `Float` 

& & `Int` & `Int` & `Int` 

`*` & multiplication & `Float` & `Float` & `Float` 

& & `Float` & `Int` & `Float` 

& & `Int` & `Float` & `Float` 

& & `Int` & `Int` & `Int` 

`/` & division & `Float` & `Float` & `Float` 

& & `Float` & `Int` & `Float` 

& & `Int` & `Float` & `Float` 

& & `Int` & `Int` & `Float` 

`%` & modulo & `Float` & `Float` & `Float` 

& & `Float` & `Int` & `Float` 

& & `Int` & `Float` & `Float` 

& & `Int` & `Int` & `Int` 
 
 
 
Operator & Operation & Argument 1 & Argument 2 & Return 
 
`==` & equal & Float/Int & Float/Int & Bool 

`!=` & not equal & Float/Int & Float/Int & Bool 

`<` & less than & Float/Int & Float/Int & Bool 

`<=` & less than or equal & Float/Int & Float/Int & Bool 

`>` & greater than & Float/Int & Float/Int & Bool 

`>=` & great than or equal & Float/Int & Float/Int & Bool 
 
 
 
Operator & Operation & Argument 1 & Argument 2 & Return 
 
`&` & bitwise and & `Int` & `Int` & `Int` 

`|` & bitwise or & `Int` & `Int` & `Int` 

`^` & bitwise xor & `Int` & `Int` & `Int` 

`<<` & shift left & `Int` & `Int` & `Int` 

`>>` & shift right & `Int` & `Int` & `Int` 

`>>>` & unsigned shift right & `Int` & `Int` & `Int`