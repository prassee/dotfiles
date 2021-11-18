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
# set --export ANDROID /data/cellar/Android
# set --export ANDROID_SDK /data/cellar/Android
# set --export ANDROID_SDK_ROOT /data/cellar/Android
# set --export FLUTTER /data/cellar/flutter
# set --export ANDROID_SDK_ROOT /data/cellar/Android/sdk

set -U fish_pager_color_prefix cyan --bold --background=brblack

# $CARGO_HOME/bin

set -gx PATH $CARGO_HOME/bin $GO_HOME/bin $GOPATH $GOBIN $JULIA_BINDIR/ $MVN_HOME/bin $SBT_HOME/bin $JDK_HOME/bin $JAVA_HOME/bin $CARGO_HOME/bin /usr/bin /data/linuxutils/utilsBin $NODE_HOME/bin $LOCAL_BIN /data/cellar/kotlinc/bin $GRADLE_HOME/bin $PATH

function initGitsRepo
    ssh git@gitserver "git init --bare ~/repos/$argv[1].git"
    git remote add gitsorigin git@gitserver:/home/git/repos/$argv[1].git
end

function cloneFromGits
    git clone git@gitserver:/home/git/repos/$argv[1].git
end

function sshToGit
    ssh -i ~/.ssh/mygits git@gitserver
end

function pushToRem
    rm -rf /data/org/.git /data/mddocs/.git /data/mindmap/.git /data/sysConfigs/.git /data/office-xbl/documents/.git

    echo "pushing to server .... "

    echo "mddocs"
    rsync -auzvPhrtp /data/mddocs/ --exclude '.git/' git@gitserver:/home/git/mddocs --delete

    echo "org"
    rsync -auzvPhrtp /data/org/ --include '*.org' --exclude '.git/' --exclude '*/' git@gitserver:/home/git/org --delete

    echo "postoffice"
    rsync -auzvPhrtp /data/postoffice/ --exclude '.git/' git@gitserver:/home/git/postoffice --delete
    
    echo "mindmap"
    rsync -auzvPhrtp /data/mindmap/ --exclude '.git/'  git@gitserver:/home/git/mindmap --delete

    echo "officedocs"
    rsync -auzvPhrtp /data/office-xbl/documents/ --exclude '.git/' git@gitserver:/home/git/officeDocs --delete

    echo "sysconfigs"
    rsync -auzvPhrtp /data/sysConfigs/ --exclude '.git/' git@gitserver:/home/git/sysConfigs --delete

    echo "ebookshelf"
    rsync -auzvPhrtp /data/ebookshelf/ --exclude '.git/'  git@gitserver:/home/git/ebookshelf --delete
     
end

function pullFromRem
    rsync -auzvPhrtp git@gitserver:/home/git/mddocs/ /data/mddocs --delete
    rsync -auzvPhrtp git@gitserver:/home/git/postoffice/ /data/postoffice --delete
    rsync -auzvPhrtp git@gitserver:/home/git/org/ /data/org --delete
    rsync -auzvPhrtp git@gitserver:/home/git/mindmap/ /data/mindmap --delete
    rsync -auzvPhrtp git@gitserver:/home/git/officeDocs/ /data/office-xbl/documents --delete
    rsync -auzvPhrtp git@gitserver:/home/git/sysConfigs/ /data/sysConfigs --delete
    rsync -auzvPhrtp git@gitserver:/home/git/ebookshelf/ /data/ebookshelf --delete
    chmod a+x /data/sysConfigs/suspension.sh
end

function createVirtEnv
    python3 -m venv $WORKON_HOME/$argv[1]
end

function workonVirtEnv
    source $WORKON_HOME/$argv[1]/bin/activate.fish    
end

function createPythonProject
    mkdir $argv[1]
    cd $argv[1]
    createVirtEnv $argv[1]
    git init .
    workonVirtEnv $argv[1]
end

function updateMetals
    coursier bootstrap --java-opt -Xss4m   --java-opt -Xms100m   --java-opt -Dmetals.client=emacs   org.scalameta:metals_2.12:0.10.4   -r bintray:scalacenter/releases   -r sonatype:snapshots   -o /data/linuxutils/utilsBin/metals-emacs -f
end

function tdadd
    t -add=$argv[1]
end

function tdlp
    t -listby="@$argv[1]"
end

function tdlc
    t -listby="*$argv[1]"
end

function tdlu
    t -listby="#$argv[1]"
end

function tddone
    t -done=$argv[1]
end

function loginConainerRegistry
    podman login rg.fr-par.scw.cloud/vamana-registry -u '${cat /data/sysConfigs/securey/scaleway-container-registry-id.txt}' -p 5a1afb5b-eadb-499f-aa0a-6e6bcd43ed39
end

function querySWContainerRegistry
    # curl -X GET --header "x-auth-token: 5a1afb5b-eadb-499f-aa0a-6e6bcd43ed39" https://api.scaleway.com/registry/v1/regions/fr-par/namespaces
    # echo ""
    # echo "--- line ---"
    curl -X GET --header "x-auth-token: 5a1afb5b-eadb-499f-aa0a-6e6bcd43ed39" "https://api.scaleway.com/registry/v1/regions/fr-par/images?name=$argv[1]" | jq
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

function loginToSWContRegistry
    # sec key 03ee9895-660b-4bfc-9e32-75394d3db7d9
    # access key SCWX9T7XX8F4SF3SKCDN
    podman rg.fr-par.scw.cloud/vamana-registry -u nologin -p 03ee9895-660b-4bfc-9e32-75394d3db7d9
end

function prunePodmanImages
    podman system prune --all --force 
    podman rmi --all 
end

source ~/.config/fish/conf.d/aliases.fish
starship init fish | source
