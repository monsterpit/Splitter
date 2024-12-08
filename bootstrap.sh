#!/bin/bash

# Function to display script usage
display_usage() {
    echo "Usage: $0 <projectType | init> $1 <brand | optional> $2 <brandenv | optional>"
    echo " 	projectType: Specify the type of project to generate."
    echo "         	     Supported values: base, pro"
    echo "  brandenv   : Environment for the brand"
    echo "               Supported values: test,uat, prod (default: uat)"
    echo " 	-h, --help : Display this help message."
}


# Check if the correct number of arguments is provided
if [ "$#" -eq 0 ]; then
    display_usage
    exit 1
fi

# Check for the help parameter
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    display_usage
    exit 0
fi



# Function to check Xcode version
check_xcode_version() {
    local xcode_version_file=".xcode-version"
    local expected_xcode_version
    local installed_xcode_version

    if [ -e "$xcode_version_file" ]; then
        expected_xcode_version=$(cat "$xcode_version_file")
    else
        echo "Error: $xcode_version_file not found."
        exit 1
    fi


    installed_xcode_version=$(xcodebuild -version | grep "Xcode" | awk '{print $2}')

    if [ "$installed_xcode_version" != "$expected_xcode_version" ]; then
        echo "Error: Xcode version $expected_xcode_version is required."
        echo "Please install Xcode version $expected_xcode_version and run the script again."
        exit 1
    fi
}

# Function to process swiftgen.yml files
process_swiftgen_files() {
    find . -name "swiftgen.yml" | while read -r swiftgen_file; do
        echo "Processing $swiftgen_file"
        output_dir=$(grep -E '^\s*output_dir\s*:\s*' "$swiftgen_file" | awk -F: '{print $2}' | xargs)
        output_file=$(grep -E '^\s*output\s*:\s*' "$swiftgen_file" | awk -F: '{print $2}' | xargs)

        if [ -n "$output_dir" ] && [ -n "$output_file" ]; then
            combined_path="$output_dir/$output_file"
            (cd "$(dirname "$swiftgen_file")" && mkdir -p "$(dirname "$combined_path")" && touch "$combined_path")
            echo "Created file at $combined_path"
        else
            echo "Error: Could not find output_dir or output in $swiftgen_file"
        fi
    done
}


# Function to generate a project
generate_project() {
    local project_type="$1"
    local brandenv="${2:-test}"

    process_swiftgen_files
    
    case "$project_type" in
        "base")
            echo "Generating base project..."
           
           cd Spliter/SpliterMax

           project_file="project_sp.yml"

            # ../../Tools/xcodegen generate --spec $project_file
            xcodegen generate --spec $project_file
            cp Templates/IDETemplateMacros.plist SpliterMax.xcodeproj/xcshareddata/IDETemplateMacros.plist

            if [ "$CI" != "true" ]; then
                open SpliterMax.xcodeproj
            else
                echo "Skipping opening project in CI environment."
            fi
            ;;
        "pro")
           echo "Generating pro project..."
           
           cd Spliter/SpliterMax

           project_file="project_sp.yml"

            ../../Tools/xcodegen generate --spec $project_file
            cp Templates/IDETemplateMacros.plist SpliterMax.xcodeproj/xcshareddata/IDETemplateMacros.plist

            if [ "$CI" != "true" ]; then
                open SpliterMax.xcodeproj
            else
                echo "Skipping opening project in CI environment."
            fi
            ;;
        *)
            echo "Unknown project: $project_type"
            exit 1
            ;;
    esac
}

# check_xcode_version

## Assign the first argument as project type. Case insensitive.
project_type="$(echo "$1" | tr '[:upper:]' '[:lower:]')"

# Assign the third argument as brandenv
if [ -n "$2" ]; then
    brandenv="$(echo "$3" | tr '[:upper:]' '[:lower:]')"
fi

# Generate the project
generate_project "$project_type" "$brandenv"
