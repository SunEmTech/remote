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
    xterm -e bash $RUN_DIR/main.sh &
}

start() {
    RETRY=3
    while [ $RETRY -ne 0 ]; do
        pull
        RETURN=$?
        if [ $RETURN -ne 0 ]; then
            echo "Wait for the internet connection"
            RETRY=`expr $RETRY - 1`
            sleep 2
            continue
        else
            break
        fi

    done
    update  
    run
}

start


