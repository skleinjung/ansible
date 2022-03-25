# Insync Role

    DISCLAIMER: It's entirely possible this role will do something unsupported and weird, and corrupt Insync in such a way that it deletes everything in your cloud account. ABSOLUTELY NO GUARANTEE IS PROVIDED that this software will function in any particular way. USE AT YOUR OWN RISK. Have backups.

This role installs and configures the [Insync](https://www.insynchq.com/) application to sync one Google Drive account to the local host. I use this to perform unattended setup of new personal desktops. The configuration mechanism uses internal implementation details of the application, and could be very brittle in environments that differ from my own in even small ways.

This role was tested against the following version(s) of Insync:

- 3.7.3.50326 (3/3/2022)

## Usage

The role recognizes the following variables (an '*' indicates variables the user must set):

- (*) `desktop_username`: name of the user for whom the app should be configured
- (*) `insync_settings_db`: absolute path to a settings.db file; See 'settings.db' below
- (*) `insync_google_drive_root`: absolute filesystem path to which Google Drive files will be synced
- (*) `insync_google_my_drive_id`: unique ID for the Google Drive account's 'My Drive' folder. See 'My Drive', below.
- `insync_config_directory`

## Limitations

The current version of this role has the following limitations:

- Local file paths are not configured for any providers other than Google Drive
- A settings.db file with more than one Google Drive account cannot be used

## Configuration Process Documentation

Insync configuration and logs are stored in sqlite3 databases. This role operates by copying and/or creating databases according to specs that were discovered during reverse engineering. There are n+1 such databases: a 'settings.db', store in `$HOME/.config/Insync`, and one database per synced account stored in `$HOME/.config/Insync/data`. There are other databases used by the application as well, but they are not needed to pre-configure it before first run.

### settings.db

For our purposes, the settings.db contains the following pieces of information:

- Insync license and account information
- Cloud provider account credentials
- General application preferences

In order to configure Insync after it is installed, we need to properly configure a settings db. Furthermore, given the secret nature of the DB contents, we do not want to include it in the role directly. The user of this role must specify (via the `insync_settings_db` variable) the location of the settings.db to use. It is recommended to properly secure this file (perhaps, via Ansible's Vault). 

The repository root contains a bash script (`scripts/update-insync-db-files`) which, among other things, copies the settings DB from the local Insync installation and properly prepares it for this role. If you wish to get this database via other means, that script can be referenced for what modifications are needed.

### Cloud Databases

Each synced cloud account has a database. They are stored in the `data` directory in the Insync config root. They are named in the following format:

```
<CLOUD_TYPE_ID>-<ACCOUNT_ID>.db
```

For Google Drive, the `CLOUD_TYPE_ID` is '`gd`'. The `ACCOUNT_ID` is stored in the `id` column from the `accounts` table of the settings.db. This role looks up the account ID from the provided settings.db, and then creates the cloud data sqlite3 database from scratch by performing the following steps:

- Recreate the schema and base data which was created by looking at an existing database
- Insert the 3 common Google Drive folders - "Shared drives', 'Shared with me', and 'My Drive'
   - The 'My Drive' folder requires your unique My Drive id, which is passed to the role via the `insync_google_my_drive_id` variable.
- Insert the filesystem item for the sync base path specified via the `insync_google_drive_root` variable.
   - This record requires the device id from the disk, and the folder's inode number. Any changes, deletions, etc. to the directory that modify these will invalidate the created database.
- Insert sync preferences (ignore rules, options for document export and conflict resolution, etc.). 
- Set the journal_mode and user_version (IMPORTANT!) to match values from a database the app creates itself

The preferences are encoded BLOBs of some type I don't fully understand, but are probably something standard with sqlite. To generate this SQL I configured everything how I wanted it in the application UI, then exported it via sqlite's `.dump` command.

### insync_google_my_drive_id

The folder id for 'My Drive' is a critical piece of configuration. I don't have an easy way to find it, however. I got mine by setting up the app manually and then running the following query:

```sql
select cl_id from cl_items where node_id = -1;
```

It's probably possible to get this via an API call, but the authentication and so forth seem like it would be more of a hassle than getting it from Insync itself.