# Writing Plugins

## Required Files

### init
This file is run on yavm initialization if the plugin is enabled. It shouldn't contain anything other than setting variables. The most important variables are `$yavm_version_files`, `$yavm_version_variables`, and `$yavm_default_version_files`.

- `$yavm_version_variables`: This associative array tells `yavm` what environment variables to look in for version strings. The keys are the name of the variable (e.g. `PYENV_VERSION`) and the value is the command that the variable is used for. For example, the line `yavm_version_variables[PYENV_VERSION]="python"` tells `yavm` to check the `$PYENV_VERSION` variable, and if it exists use the value of the variable as the version for the `python` command. Make sure that the key is the actual variable name, and not it's value. That is, don't include the dollar sign.
- `$yavm_version_files`: This associative array has the same basic behavior as `$yavm_version_varibles`, except the keys are the names of files. For example, `yavm_version_files[.python-version]="python"` will look for `.python-version` files and use the contents as the version for the `python` command. If the file you're specifying is similar to the `.tool-versions` file that asdf uses, then set the value (command) to `ANY`. For example, `yavm_version_files[.tool-versions]="ANY"`.
- `$yavm_default_version_files`: This associative array tells `yavm` what file to use if it couldn't find a version in an environment variable or file in the current directory or any of its parents. The keys are the full path to a file, and the values are the command name or `ANY`. Example: `yavm_default_version_files[$HOME/.pyenv/version]="python"`. Note that if the default file is in the `$HOME` directory you don't need to add it here, since it will be searched by default when traversing the directory tree.


### install
`TODO`
