# Windows Setup Helper

## Overview

**Windows Setup Helper** is a PowerShell-based automation tool designed to streamline the setup process on Windows. It allows users to easily install essential applications, set up Windows Subsystem for Linux (WSL), manage Windows Defender settings, and install PowerShell modules through an interactive menu.

## Features

- **Application Installation:** 
  - Installs necessary applications using Winget, with an interactive interface for users to select which applications to install.
  
- **WSL Setup:** 
  - Installs and configures Windows Subsystem for Linux (WSL) with the option to select a Linux distribution.

- **System Configuration:** 
  - Enables or disables real-time protection in Windows Defender.
  - Checks system readiness for WSL installation and other important features.

- **PowerShell Modules Installation:** 
  - Installs necessary PowerShell modules to enhance terminal functionality.

## Usage

1. Clone or download the project files to your local machine.
2. Open PowerShell and navigate to the project folder.
3. Run the main script to open the interactive menu.
4. Follow the on-screen prompts to install applications, configure WSL, manage Defender settings, or install PowerShell modules.

## Customization

- Modify the scripts to add or remove applications, change system configurations, or adjust PowerShell modules according to your needs.
- You can add more applications to the Winget installation list or customize the WSL setup process for your preferred distributions.

## Requirements

- Windows 10 or later
- PowerShell 7.x or higher
- Winget package manager (for app installations)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to fork the project, make improvements, and submit pull requests. Any contributions are welcome!
