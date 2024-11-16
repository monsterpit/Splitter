if [ "${ENABLE_PREVIEWS}" != "YES" ]; then
    if [ "${SWIFT_LINT_DIFF_ONLY}" == "YES" ]; then
        MODIFIED_SWIFT_FILES=$(git diff --name-only --relative --diff-filter=AM | grep '\.swift$') 

        # Default SwiftLint command
        swiftlint_command="$SRCROOT/Tools/swiftlint lint --use-script-input-files --force-exclude"

        # Check if SWIFT_LINT_AUTOCORRECT is set to YES
        if [ "${SWIFT_LINT_AUTOCORRECT}" == "YES" ]; then
            # Add --autocorrect to the SwiftLint command
            swiftlint_command="$swiftlint_command --autocorrect"
        fi

        for FILE in $MODIFIED_SWIFT_FILES; do
            # Run SwiftLint on a specific file
            SCRIPT_INPUT_FILE_COUNT=1 SCRIPT_INPUT_FILE_0=$FILE $swiftlint_command || true
        done
    else
        # Default SwiftLint command
        swiftlint_command="$SRCROOT/Tools/swiftlint lint"

        # Check if SWIFT_LINT_AUTOCORRECT is set to YES
        if [ "${SWIFT_LINT_AUTOCORRECT}" == "YES" ]; then
            # Add --autocorrect to the SwiftLint command
            swiftlint_command="$swiftlint_command --autocorrect"
        fi

        # Execute the SwiftLint command
        $swiftlint_command
        
    fi
fi