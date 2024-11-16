# KEYWORDS: read arduments stdout parse positional

# REFERENCES:
# https://stackoverflow.com/a/14063511
# https://stackoverflow.com/a/14203146

POSITIONAL_ARGS=()
POSITIONAL_ARGS_FOR_OPTION_S=()

while [[ $# -gt 0 ]]; do
    opt="$1";
    shift;
    # we could remove double quotes
    case "$opt" in
        "--" ) break 2;;
        "-" ) break 2;;
        "-r"|"--requires_value" )
            # current $1 is the value
            VALUE="$1"
            shift
            ;;
        "--requires_value="* )
            # current $opt contains the value
            VALUE="${opt#*=}"
            ;;
        "-d"|"--doesnt_require_value" )
            MODE=1
            ;;
        "-s"|"--set-of-positional-values" )
            # read all positional arguments after the named argument itself, 
            # until the next named argument argument
            while (( "$#" >= 1 )) && ! [[ $1 = -* ]]; do
                POSITIONAL_ARGS_FOR_OPTION_S+=( "$1" )
                shift
            done
            ;;
        -*|--*)
            echo >&2 "Invalid option: $opt"
            exit 1
            ;;
        *)
            POSITIONAL_ARGS+=("$opt") # save positional arg that do not depend on a specific named arg
            ;;
   esac
done
