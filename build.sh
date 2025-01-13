#!/bin/bash

# Get absolute path for ROS2 workspace (two directories up from this script)
ROS2_WS=$(cd "$(dirname "$0")"/../../ && pwd)

# Get project name from the current directory name
PROJECT_NAME=$(basename "$(cd "$(dirname "$0")" && pwd)")

# Function to build ROS2 package and source setup file
colcon_build() {
    # Store current directory
    CUR_DIR=$(pwd)

    echo "Building in workspace: $ROS2_WS"
    echo "Project name: $PROJECT_NAME"

    # Change to ROS2 workspace directory
    cd "$ROS2_WS"

    # Build packages with symlinks
    colcon build --packages-select "$PROJECT_NAME" --symlink-install

    # Source the setup file
    if [ -f "./install/setup.sh" ]; then
    echo "Running setup.sh ..."
        source ./install/setup.sh
    fi

    # Return to original directory
    cd "$CUR_DIR"

    echo "Build completed"
}

# Execute build function
colcon_build
