# Yet Another Version Manager (for zsh)

Yet Another Version Manager (`yavm`) is a wrapper around existing version managers to speed them up. It only works with zsh and doesn't completely replace your existing version manager. See the "Installation" section below for details about how to get up and running.

## What It Is
Most modern version managers like asdf, pyenv, and nvm are slow. They can add hundreds of milliseconds of time to the shell startup, as well as slowing down individual commands. For example, `python --version` runs in around 20ms when calling the binary directly, but with pyenv it can take over 600ms. This may not sound like much, but when you're running commands many times (e.g. in a loop) or you open new terminal windows often, this can make your computer feel slow and laggy.

These version managers are so slow because they use the concept of "shims". Every time you run a command, it will start a new shell, search your filesystem for a version file, and run the right command. On top of that, you need to keep the shims up to date when you install new packages for your language (e.g. `npm install -g`). Shims can also cause issues when programs make certain assumptions. For example, a program might assume that the location of the program is a good place to install packages. When you install a package, it may overwrite the shims, breaking the version manager.

`yavm` works differently. Rather than using shims to determine the version, `yavm` intelligently updates your `$PATH`. This means that there is no overhead when running a command. There are other version managers that do this, but what makes `yavm` different is that it's so fast that you can run it as often as you want without adding any additional lag to your shell.

It is able to be so fast because it uses highly optimized native zsh. The code that looks up the versions and sets the `$PATH` never calls an external program or even starts a subshell. The critical path is extremely minimal, only running the code that is absolutely necessary for setting the `$PATH` correctly.

## What It Doesn't Do
- Work with other shells besides zsh. I don't have any intentions of adding support for other shells, and I'm not even sure that it would work.
- Manage installing and uninstalling versions. I currently use other version managers (like asdf or pyenv) to actually handle installing and updating the versions. This may be something that I add in the future, probably by enabling the ability to add plugins.
- Keep your `$PATH` squeaky clean. Depending on how many versions of things that you have, your path may end up a little long. To me, having a fast shell is more important than having a short `$PATH`. `yavm` won't add `$PATH` entries unnecessarily, though. It only adds directories you care about, and it doesn't add directories that don't actually exist.


## Installation
1. Install the plugin as usual.
1. Add `yavm init` to your `.zshrc`.

### Environment Variables
There are three environment variables that you can use to configure `yavm`. All three are zsh arrays (i.e. initialized like `yadm_files=()`)

- `$yavm_version_variables`: This array tells `yavm` what environment variables to look in for versions. Each entry contains the command name and the name of the variable (without the `$`). For example, setting `yavm_version_variables=(python PYENV_VERSION)` will tell `yavm` to look at the `$PYENV_VERSION` environment variable, and if it is non-empty, use that as the version. It has the highest priority.
- `$yavm_version_files`: This array tells `yavm` what version files to look for. These are files like `.nvmrc`, `.tool-versions`, and `.python-version`. For each file you need to add the command and the filename. The filename is the name of the file that contains the versions (e.g. `.tool-versions`). The command indicates what command this file determines the version for (e.g. python). You can also put `ANY` here to indicate that the file contains versions for multiple commands, like `.tool-versions`. See [here](https://github.com/georgewitteman/zsh-yavm/blob/master/autoload/yavm_init#L5) for an example (and the defaults).
- `$yavm_default_version_files`: This array determines what files to look at if `yavm` couldn't find a version by environment variables or searching up the directory tree. It uses the same format as `$yavm_version_files`.
