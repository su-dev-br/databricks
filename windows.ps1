# PowerShell script for Databricks setup on Windows
$ErrorActionPreference = "Stop"

# Clone git repositories 
# git clone https://github.com/su-dev-br/databricks.git

# Navigate to the cloned directory
# cd databricks

# --------------------------------------------------
# Check Python
# --------------------------------------------------
Write-Host "Checking Python installation..." -ForegroundColor Green
python --version

# install databricks usnig windows powershell
winget install Databricks.DatabricksCLI

# --------------------------------------------------
# Create virtual environment
# --------------------------------------------------
Write-Host "Creating virtual environment..." -ForegroundColor Green
python -m venv venv

# Activate venv
Write-Host "Activating virtual environment..." -ForegroundColor Green
& ".\venv\Scripts\Activate.ps1"

# --------------------------------------------------
# Install uv + dependencies
# --------------------------------------------------
Write-Host "Upgrading pip..." -ForegroundColor Green
python.exe -m pip install --upgrade pip

Write-Host "Installing uv..." -ForegroundColor Green
python.exe -m pip install uv

Write-Host "Installing Python dependencies via uv..." -ForegroundColor Green
uv pip install -r requirements.txt
# uv pip install -r dev-requirements.txt   # optional

Write-Host "Installed packages:" -ForegroundColor Green
pip list

# --------------------------------------------------
# Install Databricks CLI (OUTSIDE venv, via pipx)
# --------------------------------------------------
Write-Host "Installing pipx (if missing)..." -ForegroundColor Green
python -m pip install --user pipx
pipx ensurepath

Write-Host "Installing Databricks CLI via pipx..." -ForegroundColor Green
pipx install databricks -f

Write-Host "Verifying Databricks CLI..." -ForegroundColor Green
databricks --version

# --------------------------------------------------
# Authenticate Databricks (modern auth)
# --------------------------------------------------
Write-Host "Authenticating with Databricks..." -ForegroundColor Green
Write-Host "Browser will open for login." -ForegroundColor Yellow
databricks auth login

Write-Host "Validating authentication..." -ForegroundColor Green
databricks current-user me

# --------------------------------------------------
# Done
# --------------------------------------------------
Write-Host "Setup completed successfully ✅" -ForegroundColor Green
Write-Host "You can now run: databricks bundle init" -ForegroundColor Cyan

# deactivate the virtual environment
# Write-Host "Deactivating virtual environment..." -ForegroundColor Green
# deactivate

# https://dbc-b1af0c2a-6757.cloud.databricks.com
# ***********