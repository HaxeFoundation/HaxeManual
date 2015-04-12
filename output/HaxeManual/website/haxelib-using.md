## 11.4 Using Haxelib

If the `haxelib` command is executed without any arguments, it prints an exhaustive list of all available arguments. Access the <http://lib.haxe.org> website to view all the libraries available. 

The following commands are available:

* Basic

    * `haxelib install [project-name] [version]` installs the given project. You can optionally specify a specific version to be installed. By default, latest released version will be installed.
    * `haxelib update [project-name]` updates a single library to their latest version. 
    * `haxelib upgrade` upgrades all the installed projects to their latest version. This command prompts a confirmation for each upgradeable project.
    * `haxelib remove project-name [version]` removes complete project or only a specified version if specified.
    * `haxelib list` lists all the installed projects and their versions. For each project, the version surrounded by brackets is the current one.
    * `haxelib set [project-name] [version]` changes the current version for a given project. The version must be already installed.
* Information

    * `haxelib search [word]` lists the projects which have either a name or description matching specified word.
    * `haxelib info [project-name]` gives you information about a given project.
    * `haxelib user [user-name]` lists information on a given Haxelib user.
    * `haxelib config` prints the Haxelib repository path. This is where Haxelib get installed by default.
    * `haxelib path [project-name]` prints paths to libraries and its dependencies (defined in `haxelib.xml`).
* Development

    * `haxelib submit [project.zip]` submits a package to Haxelib. If the user name is unknown, you'll be first asked to register an account. If the user already exists, you will be prompted for your password. If the project does not exist yet, it will be created, but no version will be added. You will have to submit it a second time to add the first released version. If you want to modify the project url or description, simply modify your `haxelib.xml` (keeping version information unchanged) and submit it again.
    * `haxelib register [project-name]` submits or update a library package.
    * `haxelib local [project-name]` tests the library package. Make sure everything (both installation and usage) is working correctly before submitting, since once submitted, a given version cannot be updated.
    * `haxelib dev [project-name] [directory]` sets a development directory for the given project. To set project directory back to global location, run command and omit directory.
    * `haxelib git [project-name] [git-clone-path] [branch] [subdirectory]` uses git repository as library. This is useful for using a more up-to-date development version, a fork of the original project, or for having a private library that you do not wish to post to Haxelib. When you use `haxelib upgrade` any libraries that are installed using GIT will automatically pull the latest version.
* Miscellaneous

    * `haxelib setup` sets the Haxelib repository path. To print current path use `haxelib config`.
    * `haxelib selfupdate` updates Haxelib itself. It will ask to run `haxe update.hxml` after this update.
    * `haxelib convertxml` converts `haxelib.xml` file to `haxelib.json`.
    * `haxelib run [project-name] [parameters]` runs the specified library with parameters. Requires  a precompiled Haxe/Neko `run.n` file in the library package. This is useful if you want users to be able to do some post-install script that will configure some additional things on the system. Be careful to trust the project you are running since the script can damage your system.
    * `haxelib proxy` setup the Http proxy.

---

Previous section: [extraParams.hxml](haxelib-extraParams.md)

Next section: [Target Details](target-details.md)