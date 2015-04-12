## 5.17 switch

A basic switch expression starts with the `switch` keyword and the switch subject expression, as well as the case expressions between curly braces `{}`. Case expressions either start with the `case` keyword and are followed by a pattern expression, or consist of the `default` keyword. In both cases a colon `:` and an optional case body expression follows:

```haxe
switch subject {
	case pattern1: case-body-expression-1;
	case pattern2: case-body-expression-2;
	default: default-expression;
}
```

Case body expressions never "fall through", so the [`break`](expression-break.md) keyword is not supported in Haxe.

Switch expressions can be used as value; in that case the types of all case body expressions and the default expression must [unify](type-system-unification.md).

Further details on syntax of pattern expressions are detailed in [Pattern Matching](lf-pattern-matching.md).

---

Previous section: [if](expression-if.md)

Next section: [try/catch](expression-try-catch.md)