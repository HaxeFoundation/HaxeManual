## 8.6 Static Analyzer

##### since Haxe 3.3.0

Haxe 3.3.0 introduces a new static analyzer for code optimizations. It is enabled by using the `-D analyzer-optimize` [compiler flag](compiler-usage-flags.md) and consists of multiple [modules](cr-static-analyzer.md#modules) which can be configured globally with a [compiler flag](compiler-usage-flags.md) as well as at type-level and field-level with a [compiler metadata](cr-metadata.md):

##### Global configuration

To globally enable an analyzer module `-D analyzer-module` is used. To globally disable a module `-D analyzer-no-module` is used. In both cases "module" represents the name of the module to be disabled or enabled:

```hxml
# Global enable from command line
haxe -D analyzer-module
# Global disable from command line
haxe -D analyzer-no-module
```

##### Local configuration

To enable an analyzer module for a given type or field `@:analyzer(module)` is used. To disable a module `@:analyzer(no_module)` is used. In both cases "module" represents the name of the module to be disabled or enabled:

```haxe
@:analyzer(module)
class C {
	@:analyzer(module) function f() { } // Field-level enable
	@:analyzer(no_module) function f() { } // Field-level disable
}
@:analyzer(no_module)
class D { } // Type-level disable
```

##### Modules

The static analyzer currently comes with the following modules. Unless noted otherwise they are enabled if `-D analyzer` is used.

* `const_propagation`: Implements sparse conditional constant propagation to promote values that are known at compile-time to usage places. Also detects dead branches.
* `copy_propagation`: Detects local variables that alias other local variables and replaces them accordingly.
* `local_dce`: Detects and removes unused local variables.
* `fusion`: Moves variable expressions to its usage in case of single-occurrence. By default, only compiler-generated variables are handled. This can be changed by using the compiler flag ``-D analyzer-user-var-fusion` or the metadata `@:analyzer(user_var_fusion)`.
* `purity_inference`: Infers if fields are "pure", i.e. do not have any side-effects. This can improve the effect of the fusion module.

---

Previous section: [RTTI structure](cr-rtti-structure.md)

Next section: [Macros](macro.md)