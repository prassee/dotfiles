# . ~/.config/fish/fish_prompt.fish

set fish_greeting '<prassee>' # turn off greeting
set --export LANG 'en_US.UTF-8'
set --export LC_CTYPE 'UTF-8'
set --export LC_ALL 'en_US.UTF-8'


function fish_title
end

set --export JDK_HOME /data/linuxutils/jdk
set --export JAVA_HOME /data/linuxutils/jdk
set --export SBT_HOME /data/linuxutils/sbt
set --export LOCAL_BIN ~/.local/bin
set --export JULIA_BINDIR /data/linuxutils/julia/bin
set --export GO_HOME /data/linuxutils/go
set --export GOPATH /data/goworkspace
set --export GOBIN /data/goworkspace/bin
set --export SYSCFG /data/sysConfigs
set --export CARGO_HOME /data/cellar/cargo
set --export VIRT_ENV_HOME /data/pyvenvs
set --export TERM screen-256color
set --export WORKON_HOME $VIRT_ENV_HOME
set --export MVN_HOME /data/cellar/apache-maven-3.6.3
set --export NODE_HOME /data/linuxutils/node
set --export GRADLE_HOME /data/linuxutils/gradle

set -U fish_pager_color_prefix cyan --bold --background=brblack


set -gx PATH $CARGO_HOME/bin $GO_HOME/bin $GOPATH $GOBIN $JULIA_BINDIR/ $MVN_HOME/bin $SBT_HOME/bin $JDK_HOME/bin $JAVA_HOME/bin $CARGO_HOME/bin /usr/bin /data/linuxutils/utilsBin $NODE_HOME/bin $LOCAL_BIN /data/cellar/kotlinc/bin $GRADLE_HOME/bin $PATH

function createVirtEnv
    python3 -m venv .venv 
    source .venv/bin/activate.fish 
    pip install --upgrade pip
end

function updateSTInstall
    cd /tmp 
    wget https://download.sublimetext.com/sublime_text_build_$argv[1]_x64.tar.xz
    tar -xvf sublime_text_build_$argv[1]_x64.tar.xz
    rm /data/cellar/sublime_text 
    mv sublime_text /data/cellar/
end

function updateSMInstall
    cd /tmp 
    wget https://download.sublimetext.com/sublime_merge_build_$argv[1]_x64.tar.xz
    tar -xvf sublime_merge_build_$argv[1]_x64.tar.xz
    rm /data/cellar/sublime_merge 
    mv sublime_merge /data/cellar/
end

function prunePodmanImages
    podman system prune --all --force 
    podman rmi --all 
end

source ~/.config/fish/aliases.fish

direnv hook fish | source

# starship init fish | source
