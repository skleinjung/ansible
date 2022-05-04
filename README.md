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

1. ~~Install QEMU Agents~~
2. lockbox.local doesn't resolve. Or issue with missing lib?
3. Set hostname based on vm, instead of 'ubuntu'
3. ~~Run via cron~~
4. Fix workspace paths for zettlr
5. Do not overwrite Spotify logins
6. ~~Better bootstrapping? Cloud init?~~
7. Web API to spin up new desktop
7. Pin correct items to task bar?
