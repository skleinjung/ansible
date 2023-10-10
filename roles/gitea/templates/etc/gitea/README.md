# Automated Ubuntu desktop setup with Ansible

## Setting up a new server

Proxmox nodes have the following scripts (installed by the `proxmox_node_ role):

- /mnt/bindmounts/proxmox-scripts/bootstrap-lxc. If run inside an LXC container, this script sets up Ansible pull.
- /usr/local/bin/provision-lxc: Uses `pct` to run the above script and setup a new LXC container (which already exists)
- The host will need to have a hostname that matches the play(s) needed for setup

Using the above scripts, the process for creating a new LXC-based server is:

- Use Proxmox to create the LXC container with the correct host name
- Mount needed scripts: `mp0: /mnt/bindmounts/proxmox-scripts,mp=/mnt/proxmox-scripts,backup=0,ro=1`
- (Optional) Create a `/var/ansible/git-ref` file, which contains the git ref that should be used to configure the container
- From the Proxmox node, run `/usr/local/bin/provision-lxc {CONTAINER_ID}`, where `{CONTAINER_ID}` is the LXC container ID

## [DEPRECATED] Workstation Quick Start

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
