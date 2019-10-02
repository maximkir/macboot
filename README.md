# Ansible Playbooks For My Development Machines [![Build Status](https://travis-ci.org/maximkir/ansible-playbooks.svg?branch=master)](https://travis-ci.org/maximkir/ansible-playbooks)

## Requirements
* Python3 (3.3+)
* pyenv

## Usage
venv is used to create a new virtual environment via the terminal command:  
`./prepare_venv.sh`

activate with:  
`source activate.sh`

and deactivate with simply:  
`deactivate`

For tool installation execute:  
`ansible-playbook -i inventory local_env.yml --tags <TAGS>`
