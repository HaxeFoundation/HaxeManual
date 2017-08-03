## 12.5.1 Getting started with Haxe/C++

The c++ target uses various c++ compilers, which are assumed to be already installed on the system, to create native executables or libraries.  The compilation happens in two phases.  Firstly, the haxe compiler generates source, header and build files in an output directory.  Secondly, the "hxcpp" [Haxelib library](haxelib.md) is invoked to run the system compilers and linkers required to generate the ultimate result.

##### Prerequisites
Before you can use the C++ target, you need in install

* hxcpp, e.g. `haxelib install hxcpp`.
* A system or cross-compiler

##### System Compilers
System compilers are supported on the three primary operating systems - Mac, Linux, and Windows.  On Mac, it is recommended that you install the latest Xcode from the Mac App Store.  On Linux, it is recommended that you use the system package manager to install the compilers and on Windows, Microsoft Visual Studio is recommended.  On Windows, you can also use gcc-based compilers.  A minimal distribution is included in a [Haxelib library](haxelib.md), and can be installed with `haxelib install minimingw`.

##### Cross Compilers
Hxcpp can be used to compile for non-host architectures if you have a suitable cross-compiler installed.  The compilers are usually supplied in the form of a Software Development Kits (SDK), or in the case of iOS devices, come with the system compiler (Xcode).  Selecting which compiler to use is achieved by defining particular variables in the hxcpp build environment.  Note that the hxcpp build tool is only responsible for producing a native executable or a native library (static or dynamic), not the complete bundling and packaging of assets and meta-data that is typically required for mobile devices.  Additional haxe libraries can be used for this task.

---

Previous section: [C++](target-cpp.md)

Next section: [The Hxcpp Build Environment](target-cpp-build-environment.md)