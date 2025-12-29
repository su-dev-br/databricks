# !/bin/bash

# clone git repositories 
# git clone https://github.com/su-dev-br/databricks.git

# navigate to the cloned directory
# cd databricks

# makesure python is installed
python --version

# create a virtual environment
python -m venv venv

# activate the virtual environment
source venv/bin/activate

# install required packages
pip install --upgrade pip
pip install -r requirements.txt

# verify installation
pip list

# configure databricks CLI
databricks configure --token
echo "Please enter your Databricks host URL (e.g., https://<your-databricks-instance>.cloud.databricks.com):"
read DATABRICKS_HOST
echo "Please enter your Databricks personal access token:"
read -s DATABRICKS_TOKEN
databricks configure --host $DATABRICKS_HOST --token $DATABRICKS_TOKEN

# confirmation validation
databricks workspace ls /

echo "Databricks CLI configured successfully."

