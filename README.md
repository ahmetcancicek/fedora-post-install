# Fedora Post Install

Bash scripts in this repository can help you to install many programs quickly. Although the script is simple, after installing the operations system, you might save your time due to using it.

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)

## Installation

Install dependencies

```bash
sudo dnf -y install \
curl
```

## Run

You can use below code.

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/ahmetcancicek/fedora-post-install/main/setup.sh)" 
```

## License

[GPLv3.0](https://choosealicense.com/licenses/gpl-3.0/)