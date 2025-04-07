#!/bin/bash
 
# Exit on error
set -e
 
# Define directories
USER_HOME="/home/$USER/Documents"
MATLAB_RUNTIME_DIR="$USER_HOME/MATLAB/MATLAB_Runtime"
MATLAB_INSTALLER_DIR="$USER_HOME/MATLAB_Runtime_R2024a"
MATLAB_ZIP="$MATLAB_INSTALLER_DIR/MATLAB_Runtime_R2024a.zip"
CONDA_ENV_NAME="pace_env"
 
# Create necessary directories
echo "Creating directories for MATLAB Runtime..."
mkdir -p "$MATLAB_RUNTIME_DIR"
mkdir -p "$MATLAB_INSTALLER_DIR"
cd "$MATLAB_INSTALLER_DIR"
 
# Download MATLAB Runtime Installer
if [ ! -f "$MATLAB_ZIP" ]; then
    echo "Downloading MATLAB Runtime R2024a..."
    wget -O "$MATLAB_ZIP" "https://ssd.mathworks.com/supportfiles/downloads/R2024a/Release/6/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2024a_Update_6_glnxa64.zip"
else
    echo "MATLAB Runtime zip already exists, skipping download."
fi
 
# Extract and install MATLAB Runtime
echo "Extracting MATLAB Runtime..."
unzip -o "$MATLAB_ZIP"
 
# Inform about installation duration and print current time
echo "Installing MATLAB Runtime. Grab a cup of coffee, as this process takes about 10 minutes."
echo "Current time: $(date)"
./install -mode silent -agreeToLicense yes -destinationFolder "$MATLAB_RUNTIME_DIR"
 
# Install Conda if not already installed
if ! command -v conda &> /dev/null; then
    echo "Conda is not installed. Please install Miniconda or Anaconda and try again."
    exit 1
fi
 
# Create a new Conda environment with Python 3.10
echo "Creating Conda environment ($CONDA_ENV_NAME) with Python 3.10..."
conda create -n "$CONDA_ENV_NAME" python=3.10 -y
 
# Activate the Conda environment
echo "Activating Conda environment..."
eval "$(conda shell.bash hook)"
conda activate "$CONDA_ENV_NAME"
 
# Install pace_neutrons
echo "Installing pace_neutrons in Conda environment..."
pip install pace_neutrons
 
# Install Jupyter
echo "Installing Jupyter in Conda environment..."
pip install jupyter
 
# Set environment variables
echo "Setting environment variables..."
export PACE_MRC_DIR="$MATLAB_RUNTIME_DIR/R2024a/"
export LD_LIBRARY_PATH="$MATLAB_RUNTIME_DIR/R2024a/runtime/glnxa64:$MATLAB_RUNTIME_DIR/R2024a/bin/glnxa64:$MATLAB_RUNTIME_DIR/R2024a/sys/os/glnxa64:$MATLAB_RUNTIME_DIR/R2024a/extern/bin/glnxa64:$MATLAB_RUNTIME_DIR/R2024a/sys/opengl/lib/glnxa64"
 
# Write environment variables to shell profile for persistence
echo "Exporting environment variables to ~/.bashrc..."
echo "export PACE_MRC_DIR=$MATLAB_RUNTIME_DIR/R2024a/" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> ~/.bashrc
 
# Reminder to activate the environment
echo "Setup complete! To use 'pace_neutrons', activate the Conda environment:"
echo "    conda activate $CONDA_ENV_NAME"
echo "And source your environment variables if not already done:"
echo "    source ~/.bashrc"