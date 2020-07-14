# Yet Another Version Manager (for zsh)

Yet Another Version Manager (`yavm`) is a wrapper around existing version managers to speed them up. It only works with zsh and doesn't completely replace your existing version manager. See the "Installation" section below for details about how to get up and running.

Eventually I want to add the capability for plugins to actually handle installing the actual commands, making this a real version manager. See the "Roadmap" section below.

## Installation
1. Install the plugin using a zsh plugin manager or by cloning the repository and sourcing `zsh-yavm.plugin.zsh`.
1. Add `yavm init PLUGIN [PLUGIN...]` to your `.zshrc`.

## What It Is
Most modern version managers like asdf, pyenv, and nvm are slow. They can add hundreds of milliseconds of time to the shell startup, as well as slowing down individual commands. For example, `python --version` runs in around 20ms when calling the binary directly, but with pyenv it can take over 600ms. This may not sound like much, but when you're running commands many times (e.g. in a loop) or you open new terminal windows often, this can make your computer feel slow and laggy.

These version managers are so slow because they use the concept of "shims". Every time you run a command, it will start a new shell, search your filesystem for a version file, and run the right command. On top of that, you need to keep the shims up to date when you install new packages for your language (e.g. `npm install -g`). Shims can also cause issues when programs make certain assumptions. For example, a program might assume that the location of the program is a good place to install packages. When you install a package, it may overwrite the shims, breaking the version manager.

`yavm` works differently. Rather than using shims to determine the version, `yavm` intelligently updates your `$PATH`. This means that there is no overhead when running a command. There are other version managers that do this, but what makes `yavm` different is that it's so fast that you can run it as often as you want without adding any additional lag to your shell.

It is able to be so fast because it uses highly optimized native zsh. The code that looks up the versions and sets the `$PATH` never calls an external program or even starts a subshell. The critical path is extremely minimal, only running the code that is absolutely necessary for setting the `$PATH` correctly.

## What It Doesn't Do
- Work with other shells besides zsh. I don't have any intentions of adding support for other shells, and I'm not even sure that it would work.
- Manage installing and uninstalling versions. I currently use other version managers (like asdf or pyenv) to actually handle installing and updating the versions. This is something that I plan on adding in the future.
- Keep your `$PATH` squeaky clean. Depending on how many versions of things that you have, your path may end up a little long. To me, having a fast shell is more important than having a short `$PATH`. `yavm` won't add `$PATH` entries unnecessarily, though. It only adds directories for commands you enable, and it doesn't add directories that don't actually exist.

## Roadmap
1. Support installing versions of python.
1. Support other languages.
1. Sometimes an script expects that everyone that uses the script will be using the same version manager. It would be nice if `yavm` could set up a fake executable that would simulate another version manager (e.g. `pyenv`). This would allow `yavm` to be a drop in replacement for other version managers.
