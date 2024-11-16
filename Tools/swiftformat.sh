
# if [ "${ENABLE_PREVIEWS}" != "YES" ]; then
#     MODIFIED_SWIFT_FILES=$(git diff --name-only --relative --diff-filter=AM | grep '\.swift$') 
#     for FILE in $MODIFIED_SWIFT_FILES; do
#         SCRIPT_INPUT_FILE_COUNT=1 SCRIPT_INPUT_FILE_0=$FILE $SRCROOT/../../Tools/swiftformat  "$PROJECT_DIR/$FILE"
#     done

# fi

if [ "${ENABLE_PREVIEWS}" != "YES" ]; then
    echo "Getting modified Swift files..." # Informational message
    MODIFIED_SWIFT_FILES=$(git diff --name-only --relative --diff-filter=AM | grep '\.swift$') 


   # Get the absolute path of the current folder
    CURRENT_FOLDER=$(pwd) # This retrieves the current working directory

    # Display the current folder for confirmation
    echo "Current Folder: $CURRENT_FOLDER"

    # Output the list of modified Swift files
    echo "Modified Swift files:"
    echo "$MODIFIED_SWIFT_FILES"


    echo "Ls files"
    # Optionally, list the directory contents
    ls # List Tools directory content


    
    for FILE in $MODIFIED_SWIFT_FILES; do
        # Display the file being processed
        echo "Applying SwiftFormat to $FILE"

        # Run SwiftFormat on the current Swift file
        SCRIPT_INPUT_FILE_COUNT=1 SCRIPT_INPUT_FILE_0=$FILE $SRCROOT/Tools/swiftformat  "$CURRENT_FOLDER/$FILE"
    done
    
fi