# How to use the dedicated server

## Disclaimer

​        This is an early release (alpha) which we don't fully support yet. It might contain severe issues and we could stop supporting it at any time.     

## Platforms

### Linux

​        Unzip the container file into an empty folder. Start the server with the following command:     

> ​        LD_LIBRARY_PATH=. ./bedrock_server     

### Windows

​        Unzip the container file into an empty folder. Start the server by executing the `bedrock_server.exe` file.     

​        On some systems, when you wish to connect to the server using a client running on the same machine as the        server is running on, you will need to exempt the Minecraft client from UWP loopback restrictions:          

> CheckNetIsolation.exe LoopbackExempt –a –p=S-1-15-2-1958404141-86561845-1752920682-3514627264-368642714-62675701-733520436

## Configuration

​        The server will try to read a file named `server.properties`. Some of these options are only read when a new world is created, while some others are read every startup. The file should contain a list with keys and values separated with an equal sign, one per line.     

​        The following options are available. If a value as a number in parenthesis, that number can be used instead of the text value.     

| Option name                     | Possible values                              | Default value    | When is it used                | Notes                                                        |
| ------------------------------- | -------------------------------------------- | ---------------- | ------------------------------ | ------------------------------------------------------------ |
| gamemode                        | survival (0), creative (1), adventure (2)    | survival         | Always or only for new players |                                                              |
| difficulty                      | peaceful (0), easy (1), normal (2), hard (3) | easy             | Always                         |                                                              |
| level-type                      | FLAT, LEGACY, DEFAULT                        | DEFAULT          | World creation                 |                                                              |
| server-name                     | Any string                                   | Dedicated Server | Always                         | This is the server name shown in the in-game server list.    |
| max-players                     | Any integer                                  | 10               | Always                         | The maximum numbers of players that should be able to play on the server. **Higher values have performance impact.** |
| server-port                     | Any integer                                  | 19132            | Always                         |                                                              |
| server-portv6                   | Any integer                                  | 19133            | Always                         |                                                              |
| level-name                      | Any string                                   | level            | Always                         | The name of level to be used/generated. Each level has its own folder in `/worlds`. |
| level-seed                      | Any string                                   |                  | World creation                 | The seed to be used for randomizing the world. If left empty a seed will be chosen at random. |
| online-mode                     | true, false                                  | true             | Always                         | If true then all connected players must be authenticated to Xbox Live.                    Clients connecting to remote (non-LAN) servers will always require Xbox Live authentication regardless of this setting.                    If the server accepts connections from the Internet, then it's **highly** recommended to enable online-mode. |
| white-list                      | true, false                                  | false            | Always                         | If true then all connected players must be listed in the separate `whitelist.json` file.                            See the *Whitelist* section. |
| allow-cheats                    | true, false                                  | false            | Always                         |                                                              |
| view-distance                   | Any integer                                  | 10               | Always                         | The maximum allowed view distance. **Higher values have performance impact.** |
| player-idle-timeout             | Any integer                                  | 30               | Always                         | After a player has idled for this many minutes they will be kicked. If set to 0 then players can idle indefinitely. |
| max-threads                     | Any integer                                  | 8                | Always                         | Maximum number of threads the server will try to use.        |
| tick-distance                   | An integer in the range [4, 12]              | 4                | Always                         | The world will be ticked this many chunks away from any player. **Higher values have performance impact.** |
| default-player-permission-level | visitor, member, operator                    | member           | Always                         | Which permission level new players will have when they join for the first time. |
| texturepack-required            | true, false                                  | false            | Always                         | If the world uses any specific texture packs then this setting will force the client to use it. |

### Example server.properties file

> ​        server-name=Dedicated Server
>         gamemode=survival
>         difficulty=easy
>         allow-cheats=false
>         max-players=10
>         online-mode=true
>         white-list=false
>         server-port=19132
>         server-portv6=19133
>         view-distance=10
>         tick-distance=4
>         player-idle-timeout=30
>         max-threads=8     

## Folders

​        When unpacking you will see a few folders and the binary executable. When starting the server for the first time a bunch of new (empty) folders will be created. The folders you should care about are the following:     

| Folder name    | Purpose                                                      |
| -------------- | ------------------------------------------------------------ |
| behavior_packs | This is where new behavior packs can be installed. At the moment there's no way of activating                            them in a level. |
| resource_packs | This is where new resource packs can be installed. At the moment there's no way of activating                            them in a level. |
| worlds         | This folder will be created at startup if it doesn't already exist. Every world created will have a folder named according to their `level-name` inside the `server.properties` file. |

## Whitelist

​        If the `white-list` property is enabled in `server.properties` then the server will only allow selected users to connect. To allow a user to connect you need to know their Xbox Live Gamertag. The easiest way to add a user to the whitelist is to use the command `whitelist add <Gamertag>` (eg: `whitelist add ExampleName`). Note: If there is a white-space in the Gamertag you need to enclose it with double quates: `whitelist add "Example Name"`     

​        If you later want to remove someone from the list you can use the command `whitelist remove <Gamertag>`.     

​        The whitelist will be saved in a file called `whitelist.json`. If you want to automate the process of adding or removing players from it you can do so. After you've modified the file you need to run the command `whitelist reload` to make sure that the server knows about your new change.     

​        The file contains a JSON array with objects that contains the following key/values.     

| Key                | Type    | Value                                                        |
| ------------------ | ------- | ------------------------------------------------------------ |
| name               | String  | The gamertag of the user.                                    |
| xuid               | String  | Optional. The XUID of the user. If it's not set then it will be populated when someone with a matching name connects. |
| ignoresPlayerLimit | Boolean | True if this user should not count towards the maximum player limit. Currently there's another soft limit of 30 (or 1 higher than the specified number of max players) connected players, even if players use this option. The intention for this is to have some players be able to join even if the server is full. |

​        Example `whitelist.json` file:     

```
[
    {
        "ignoresPlayerLimit": false,
        "name": "MyPlayer"
    },
    {
        "ignoresPlayerLimit": false,
        "name": "AnotherPlayer",
        "xuid": "274817248"
    }
]
```

## Permissions

​        You can adjust player specific permissions by assigning them roles in the `permissions.json` that is placed in the same directory as the server executable. The file contains a simple JSON object with XUIDs and permissions. Valid permissions are: `operator`, `member`, `visitor`. Every player that connects with these accounts will be treated according to the set premission. If you change this file while the server is running, then run the command `permissions reload` to make sure that the server knows about your new change. You could also list the current permissions with `permissions list`. Note that `online-mode` needs to be enabled for this feature to work since xuid requires online verification of the user account. If a new player that is not in this list connects, the `default-player-permission-level` option will apply.     

​        Example `permissions.json` file:     

```
[
    {
        "permission": "operator",
        "xuid": "451298348"
    },
    {
        "permission": "member",
        "xuid": "52819329"
    },
    {
        "permission": "visitor",
        "xuid": "234114123"
    }
]
```

## Crash reporting

​        If the server crashes it will automatically send us various information that helps us solve it for the future.     

## Commands

​        You can issue commands to the server by typing in the console. The following commands are available. < > means a parameter is required, [ ] means it's optional and | denotes different allowed values. Strings can be enclosed in double quotes, ", if they contain spaces.     

| Command syntax                          | Description                                                  |
| --------------------------------------- | ------------------------------------------------------------ |
| kick <player name or xuid> <reason>     | Immediately kicks a player. The reason will be shown on the kicked players screen. |
| stop                                    | Shuts down the server gracefully.                            |
| save <hold \| resume \| query>          | Used to make atomic backups while the server is running. See the backup section for more information. |
| whitelist <on \| off \| list \| reload> | `on` and `off` turns the whitelist on and off. Note that this does not change the value in the `server.properties` file!                     `list` prints the current whitelist used by the server                     `reload` makes the server reload the whitelist from the file.                                             See the Whitelist section for more information. |
| whitelist <add \| remove> <name>        | Adds or removes a player from the whitelist file. The name parameter should be the Xbox Gamertag of the player you want to add or remove. You don't need to specify a XUID here, it will be resolved the first time the player connects.See the Whitelist section for more information. |
| ops <list \| reload>                    | `list` prints the current used operator list.                     `reload` makes the server reload the operator list from the ops file.                                             See the Whitelist section for more information. |
| changesetting <setting> <value>         | Changes a server setting without having to restart the server. Currently only two settings are supported to be changed, `allow-cheats` (true or false) and `difficulty` (0, `peaceful`, 1, `easy`, 2, `normal`, 3 or `hard`). They do not modify the value that's specified in `server.properties`. |

## Backups

​        The server supports taking backups of the world files while the server is running. It's not particularly friendly for taking manual backups, but works better when automated. The backup (from the servers perspective) consists of three commands.     

| Command     | Description                                                  |
| ----------- | ------------------------------------------------------------ |
| save hold   | This will ask the server to prepare for a backup. It’s asynchronous and will return immediately. |
| save query  | After calling `save hold` you should call this command repeatedly to see if the preparation has finished. When it returns a success it will return a file list (with lengths for each file) of the files you need to copy. The server will not pause while this is happening, so some files can be modified while the backup is taking place. As long as you only copy the files in the given file list and truncate the copied files to the specified lengths, then the backup should be valid. |
| save resume | When you’re finished with copying the files you should call this to tell the server that it’s okay to remove old files again. |