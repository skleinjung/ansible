# Automated Ubuntu desktop setup with Ansible

## Quick Start

1. Install Ubuntu
2. Store vault password in a file called `.vault-secret`, set permissions to '0600'
  - This cannot be specified interactively currently (by design...)
3. Bootstrap ansible: `wget -O - -o /dev/null https://raw.githubusercontent.com/skleinjung/ansible/main/scripts/bootstrap | sudo bash`

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
