The `|` operator can be used anywhere within patterns to describe multiple accepted patterns:

```
case 4 | 1: "0";
case 6 | 7: "1";
case _: "2";

race(match); // 1
```

If there's a captured variable in an or-pattern, it must appear in both its sub-patterns.