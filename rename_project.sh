#!/bin/bash

usage() {
    echo "Usage: $0 new_name [old_name]"
    echo "  new_name: New project name to replace with"
    echo "  old_name: Original project name (default: ros2_uv_template)"
    exit 1
}

# Check arguments
if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    usage
fi

NEW_NAME="$1"
OLD_NAME="${2:-ros2_uv_template}"

# Validate new name
if [[ ! "$NEW_NAME" =~ ^[a-z][a-z0-9_]*$ ]]; then
    echo "Error: New name must start with a letter and contain only lowercase letters, numbers, and underscores"
    exit 1
fi

# Detect OS and set sed command
if [[ "$OSTYPE" == "darwin"* ]]; then
    replace_in_file() {
        sed -i '' "s/$1/$2/g" "$3"
    }
else
    replace_in_file() {
        sed -i "s/$1/$2/g" "$3"
    }
fi

echo "Renaming project from '$OLD_NAME' to '$NEW_NAME'"

# Function to replace content in files
replace_in_files() {
    local old="$1"
    local new="$2"
    local file_list=(
        "CMakeLists.txt"
        "Dockerfile"
        "docker-compose.yml"
        "package.xml"
        "pyproject.toml"
        "scripts/publisher.py"
        "scripts/subscriber.py"
    )

    for file in "${file_list[@]}"; do
        if [ -f "$file" ]; then
            echo "Updating $file"
            replace_in_file "$old" "$new" "$file"
        fi
    done
}

# Function to rename directories
rename_directories() {
    local old="$1"
    local new="$2"

    if [ -d "src/$old" ]; then
        echo "Renaming directory src/$old to src/$new"
        mv "src/$old" "src/$new"
    fi
}

# Main execution
# 1. Replace content in files
replace_in_files "$OLD_NAME" "$NEW_NAME"

# 2. Replace hyphenated version in pyproject.toml (if exists)
OLD_NAME_HYPHEN=$(echo "$OLD_NAME" | tr '_' '-')
NEW_NAME_HYPHEN=$(echo "$NEW_NAME" | tr '_' '-')
if [ -f "pyproject.toml" ]; then
    replace_in_file "$OLD_NAME_HYPHEN" "$NEW_NAME_HYPHEN" "pyproject.toml"
fi

# 3. Rename directories
rename_directories "$OLD_NAME" "$NEW_NAME"

echo "Project renamed successfully!"
