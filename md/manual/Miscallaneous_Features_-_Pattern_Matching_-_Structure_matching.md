It is now also possible to match against the fields of anonymous structures and instances:

```

```

Note that in the second case, we bind the matched `name` field to identifier `n` if `rating` matches `"awesome"`. Of course you could also put this structure into the `Tree` from the previous example and combine structure and enum matching.

A limitation with regards to class instances is that you cannot match against fields of their parent class.