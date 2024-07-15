# KEYWORDS: read arduments stdout parse positional

# REFERENCES:
# https://stackoverflow.com/a/14063511
# https://stackoverflow.com/a/14203146

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
    opt="$1";
    shift;
    # we could not use any double quotes
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
        -*|--*)
            echo >&2 "Invalid option: $opt"
            exit 1
            ;;
        *)
            POSITIONAL_ARGS+=("$1") # save positional arg
            ;;
   esac
done
