#!/bin/bash
# wrapper f
# Docker shells by default run as nonlogin, noninteractive
## It is insufficient to run `conda init bash` in a dockerfile, and then `source $HOME/.bashrc` in the entry script.
## This is mostly because the `RUN` directives are noninteractive, non-login shells, meaning `.bashrc` is never 
## sourced, and `RUN source` does not behave the way one might naively think it should
# using ideas from https://gist.github.com/xkortex/84226629c2a1286120bf139b93bca9bf

# This script will run as wrapper for conpair
# it will create a subshell, activate the conda env conpair and run conpair before exiting the shell
__conda_setup="$('/opt2/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
eval "$__conda_setup"
unset __conda_setup
export CONPAIR_DIR="/opt2/Conpair"
export PATH="$PATH:$CONPAIR_DIR/scripts"
export PYTHONPATH="$PYTHONPATH:$CONPAIR_DIR/modules/"
conda activate conpair
>&2 echo "USING conpair CONDA env!"
exec $CONPAIR_DIR/scripts/verify_concordance.py $@
