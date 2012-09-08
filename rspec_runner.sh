#!/bin/bash

spork &

pipe=/tmp/rspec_runner

trap "rm -f $pipe" EXIT

if [[ ! -p $pipe ]]; then
    mkfifo $pipe
fi

while true
do
    if read line <$pipe; then
        if [[ "$line" == 'quit' ]]; then
            break
        fi
        clear
        echo "Running $line"
        $line | tee /tmp/rspec_runner_out
    fi
done

echo "Runner exiting"
