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
}

update() {
    cp $PULL_DIR/* $RUN_DIR
}

run() {
    bash $RUN_DIR/main.sh
}

start() {
    RETRY=3
    if [ $RETRY -ne 0 ]; then
        RETURN=`pull`
        if [ $RETURN -ne 0 ]; then
            echo "Check for the internet connection"
            continue
        else
            break
        fi
        RETRY=`expr $RETRY - 1`
    fi 
    update  
    run
}

