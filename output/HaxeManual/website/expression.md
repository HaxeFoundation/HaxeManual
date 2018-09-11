## 5 Expressions

Expressions in Haxe define what a program **does**. Most expressions are found in the body of a [method](class-field-method.md), where they are combined to express what that method should do. This section explains the different kinds of expressions. Some definitions help here:

> ##### Define: Name
>
> A general name may refer to
> 
> * a type,
> * a local variable,
> * a local function or
> * a field.
> 

> ##### Define: Identifier
>
> Haxe identifiers start with an underscore `_`, a dollar `$`, a lower-case character `a-z` or an upper-case character `A-Z`. After that, any combination and number of `_`, `A-Z`, `a-z` and `0-9` may follow.
> 
> Further limitations follow from the usage context, which are checked upon typing:
> 
> * Type names must start with an upper-case letter `A-Z` or an underscore `_`.
> * Leading dollars are not allowed for any kind of [name](dictionary.md#define-name) (dollar-names are mostly used for [macro reification](macro-reification.md)).
> 

##### since Haxe 3.3.0

Haxe reserves the identifier prefix `_hx_` for internal use. This is not enforced by the parser or typer.

##### Keywords

The following Haxe keywords may not be used as identifiers:

* abstract
* break
* case
* cast
* catch
* class
* continue
* default
* do
* dynamic
* else
* enum
* extends
* extern
* false
* for
* function
* if
* implements
* import
* in
* inline
* interface
* macro
* new
* null
* override
* package
* private
* public
* return
* static
* switch
* this
* throw
* true
* try
* typedef
* untyped
* using
* var
* while

##### Related content

* Haxe Code Cookbook  article: [Everything is an expression](http://code.haxe.org/category/principles/everything-is-an-expression.html).

---

Previous section: [Static](class-field-static.md)

Next section: [Blocks](expression-block.md)