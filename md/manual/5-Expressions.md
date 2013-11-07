## 5 Expressions

>TODO: I feel like this section should come sooner in the manual.
Expressions in haxe define what a program **does**. Most expressions are found in the body of a [method](4.3-Method.md), where they are combined to express what that method should do. This section explains the different kinds of expressions. Some definitions help here:

> ##### Define: Name
>
> A general name may refer to
> 
> 
> * a type,
> * a local variable,
> * a local function or
> * a field.
> 
> 


> ##### Define: Identifier
>
> Haxe identifiers start with an underscore `_`, a dollar `$`, a lower-case character `a-z` or an upper-case character `A-Z`. After that, any combination and number of `_`, `A-Z`, `a-z` and `0-9` may follow.
> 
> Further limitations follow from the usage context, which are checked upon typing:
> 
> 
> * Type names must start with an upper-case letter `A-Z` or an underscore `_`.
> * Leading dollars are not allowed for any kind of [name](dictionary.md#name) (dollar-names are mostly used for [macro reification](8.3-Reification.md)).
> 
>

---

Previous section: [Effects of Variance and Access Modifiers](4.5.1-Effects_of_Variance_and_Access_Modifiers.md)

Next section: [Blocks](5.1-Blocks.md)