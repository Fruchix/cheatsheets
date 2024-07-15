# KEYWORDS: bash for loop parallel ctrl c ctrl-c trap pids background process

# REFERENCES:
# https://stackoverflow.com/a/356154
# https://stackoverflow.com/a/59723887

# FURTHER READING:
# https://stackoverflow.com/a/70670852 (not used for this)
# https://stackoverflow.com/questions/6441509/how-to-write-a-process-pool-bash-shell (not used for this)
# https://stackoverflow.com/questions/3004811/how-do-you-run-multiple-programs-in-parallel-from-a-bash-script (not used for this)

# CTRL-C TRAP to stop background processing 
trap ctrl_c INT
function ctrl_c() {
    for pid in $pids; do
        # don't print error messages if $pid does not run anymore
        kill -9 $pid 2> /dev/null
    done
    exit 1
}

# get PID with $!
# "wait -n": continue on the first process to stop, get its return value with "$?"

function run_parallel() {
    # stop at first fail
    FIRST_FAIL=1
    pids=""

    # keep output of each process using files
    process >> file1.tmp &
    pids="$pids $!"
    process >> file2.tmp &
    pids="$pids $!"
    process >> file3.tmp &
    pids="$pids $!"

    if [[ ${FIRST_FAIL} -eq 1 ]]; then
        for i in $pids; do
            # don't print error messages
            wait -n $pids 2> /dev/null

            # kill all processes if one failed
            if [[ "$?" -ne 0 ]]; then
                ctrl_c
            fi
        done
    else
        wait $pids
    fi

}


