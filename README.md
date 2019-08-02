# Ansible Playbooks For My Development Machines

## Requirements
* Python3
* pyenv

## Usage
venv is used to create a new virtual environment via the terminal command: 
`./prepare_venv.sh`

activate with: 
`./activate.sh`

and deactivate with simply: 
`deactivate`

For tool installation execute: 
`ansible-playbook -i hosts local_env.yml --tags <TAGS>`