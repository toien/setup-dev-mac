### desc

[pyenv](https://github.com/pyenv/pyenv) is my fav tool to manage multiple python versions.

use git checkout for installation.

also add [virtualenv plugin](https://github.com/pyenv/pyenv-virtualenv) for pyenv.


if you met this [issue](https://github.com/pyenv/pyenv-virtualenv/issues/135) (virtualenv not 
showing python version in shell prompt), just change your $PS1 by:

```
export PS1='\n$(pyenv version-name)\n'$PS1

```

another thing to be metioned is be guardedly consider use **pyenv** and **anaconda** at same time.

it seems they may lead to conflicts, see [details](https://stackoverflow.com/questions/58044214/installing-anaconda-with-pyenv-unable-to-configure-virtual-environment)

