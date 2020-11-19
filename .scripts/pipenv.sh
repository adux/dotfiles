#!/bin/zsh
function auto_pipenv_shell {
    if [ ! -n "${PIPENV_ACTIVE+1}" ]; then
        if [ -f "Pipfile" ] ; then
            pipenv shell
        fi
    fi
}

function cd {
    builtin cd "$@"
    auto_pipenv_shell
}

auto_pipenv_shell