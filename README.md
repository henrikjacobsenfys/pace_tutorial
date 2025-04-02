# How to use pace - a short introduction
This is an introduction to using the Python version of the software package Proper Analysis of Coherent Excitations (pace), developed at ISIS. This tutorial gives a short introduction to the main concepts. We will work with a demo data set, which takes about 30 minutes to set up. First, pace needs to be installed, and then the test data needs to be generated.

## Installation
The easiest way to install pace on VISA is to download and run the following shell script: XXXXXXXX. After it has been downloaded, make it runable by navigating to the folder in the terminal and type

`chmod +x pace_install.sh`

and then execute the script by typing ./pace_install.sh in the terminal. The shell script will set up a conda environment and download and install everything that is needed. When installation is complete, you activate the environment by typing

`conda activate pace_env`

You also need to then type

`source ~/.bashrc`

Finally, this tutorial runs in Jupyter Notebooks, so open Jupyter by typing

`jupyter notebook`.