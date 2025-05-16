# How to use pace - a short introduction
This is an introduction to using the Python version of the software package Proper Analysis of Coherent Excitations (pace), developed at ISIS. This tutorial gives a short introduction to the main concepts. We will work with a demo data set, which takes about 30 minutes to set up. First, pace needs to be installed, which takes about 10 minutes, and then the test data needs to be generated. The rest of the tutorials should not take long to run.

## Installation
The easiest way to install pace on VISA is to use the pace_install.sh shell script in this tutorial. Make it runable by navigating to the folder in the terminal and type

`chmod +x pace_install.sh`

and then execute the script by typing 
`./pace_install.sh`
in the terminal. The shell script will set up a conda environment and download and install everything that is needed. When installation is complete, you activate the environment by typing

`conda activate pace_env`

You also need to then type

`source ~/.bashrc`

If Matlab Runtime is not found, try to close the terminal and open a new one.

Finally, this tutorial uses Jupyter Notebooks, so open Jupyter by typing

`jupyter notebook`.

To save a few minutes, you may want to first run the notebook named 'generate_data.ipynb'. Let it run in the background, while you start tutorial 1. (The end of that tutorial also tells you to run this notebook).

(If you don't want to use the pace_install.sh script, you can also install pace manually. To do so, follow the installation guidelines on the pace_python github https://github.com/pace-neutrons/pace-python. pace requires Matlab Compiler Runtime to be installed. Be careful to set the right library paths at the end of installation, as the program will not run if this is done incorrectly.)
