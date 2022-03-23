# Automated Ubuntu desktop setup with Ansible

## Quick Start

1. Install Ubuntu
2. Install git (`sudo apt install git`)
3. Install Ansible (`sudo apt install ansible`)
4. Install dependencies:
  - `ansible-galaxy collection install community.general`
  - `ansible-galaxy collection install ansible.posix`
4. Store vault password in a file called `.vault-secret`
  - This cannot be specified interactively currently (by design...)
5. Run the playbook (`ansible-pull --vault-password-file .vault-secret --ask-become-pass --purge --accept-host-key -i '<HOST_NAME>,' -U https://github.com/skleinjung/ansible.git Configure-Desktop.yml`)
  - Remember to replace '<HOST_NAME>' in the above command

## Next Steps

1. Configure VS Code
2. Configure InSync
3. Run via Cron