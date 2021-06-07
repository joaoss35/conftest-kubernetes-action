#!/bin/bash -Ee


echo "
  _____             __ _            _     _        _____ _             _   _
 / ____|           / _| |          | |   (_)      / ____| |           | | (_)
| |     ___  _ __ | |_| |_ ___  ___| |_   _ ___  | (___ | |_ __ _ _ __| |_ _ _ __   __ _
| |    / _ \| '_ \|  _| __/ _ \/ __| __| | / __|  \___ \| __/ _\` | '__| __| | '_ \ / _\` |
| |___| (_) | | | | | | ||  __/\__ \ |_  | \__ \  ____) | || (_| | |  | |_| | | | | (_| |
 \_____\___/|_| |_|_|  \__\___||___/\__| |_|___/ |_____/ \__\__,_|_|   \__|_|_| |_|\__, |
                                                                                    __/ |
                                                                                   |___/
"

# ------ Conftest Command Arguments ------
#$COMBINE
#$COMMENT
#$NAMESPACE
#$OUTPUT
#$PARSER
#$FILE
#$POLICY
#$TOKEN
#$TRACE
#$UPDATE

# ------ Variables ------
#$CONFTEST_COMMAND
#$CONFTEST_OUTPUT
#$SUCCESS

# ------ Main ------
cd "${GITHUB_WORKSPACE}/${WORKING_DIR}"

OPTIONS=("$COMBINE" "$NAMESPACE" "$OUTPUT" "$PARSER" "$FILE" "$POLICY" "$TRACE" "$UPDATE")

# Check if all variables are defined
for i in "${OPTIONS[@]}";
do
    if [ -z "${i}" ]; then
        echo "Not all Conftest options are defined. Exiting..."
        exit 1
    fi
done

# Run Conftest test command
CONFTEST_COMMAND="/usr/local/bin/conftest test --combine=$COMBINE -n $NAMESPACE --parser=$PARSER -p $POLICY -o $OUTPUT -u $UPDATE --trace=$TRACE $FILE"
CONFTEST_OUTPUT="$(sh -c "${CONFTEST_COMMAND}" 2>&1)"
SUCCESS=$?

# Check if Conftest run successfully
if [ ${SUCCESS} -eq 0 ]; then
  echo "Conftest has successfully validated your files"
  echo "${CONFTEST_OUTPUT}"
  exit 0
else
  # If not throw an error
  echo "Conftest has failed validating your files"
  exit 1
fi
