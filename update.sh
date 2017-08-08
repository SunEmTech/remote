#!/bin/bash
# Pull and run
PULL_DIR=$HOME/pull
RUN_DIR=$HOME/run
GIT_PATH=http://github.com/SunEmTech/remote

pull() {

    if ! [ -f $PULL_DIR/main.sh ]; then
        git clone $GIT_PATH $PULL_DIR
        return $?
    else
        git -C $PULL_DIR pull
        return $?
    fi 
    return 1
}

update() {
    mkdir -p $RUN_DIR
    cp $PULL_DIR/* $RUN_DIR
}

run() {
    bash $RUN_DIR/main.sh
}

start() {
    RETRY=3
    while [ $RETRY -ne 0 ]; do
        pull
        RETURN=$?
        if [ $RETURN -ne 0 ]; then
            echo "Check for the internet connection"
            continue
        else
            break
        fi
        RETRY=`expr $RETRY - 1`
    done
    update  
    run
}

start


