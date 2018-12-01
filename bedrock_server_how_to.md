# How to use the dedicated server

> **翻译**：MilkMC Hailay

## Disclaimer(免责声明)

​        This is an early release (alpha) which we don't fully support yet. It might contain severe issues and we could stop supporting it at any time. 

（这是一个我们还没有完全支持的早期版本(alpha)。它可能包含严重的问题，我们可以在任何时候停止支持它。）    

## Platforms（平台）

### Linux

​        Unzip the container file into an empty folder. Start the server with the following command:     

（将容器文件解压缩到空文件夹中，使用以下命令启动服务器：）

> ​        LD_LIBRARY_PATH=. ./bedrock_server     

### Windows

​        Unzip the container file into an empty folder. Start the server by executing the `bedrock_server.exe` file.   

（将容器文件解压缩到空文件夹中，通过执行`bedrock_server.exe` 文件启动服务器。）  

​        On some systems, when you wish to connect to the server using a client running on the same machine as the server is running on, you will need to exempt the Minecraft client from UWP loopback restrictions:  

（在某些系统上，当您希望使用运行在与服务器相同机器上的客户端连接到服务器时，您需要去除Minecraft客户端受UWP回路限制）        

> CheckNetIsolation.exe LoopbackExempt –a –p=S-1-15-2-1958404141-86561845-1752920682-3514627264-368642714-62675701-733520436

## Configuration（配置）

​        The server will try to read a file named `server.properties`. Some of these options are only read when a new world is created, while some others are read every startup. The file should contain a list with keys and values separated with an equal sign, one per line.     

（服务器将尝试读取一个名为`server.properties`的文件。其中一些选项只在创建新世界时读取，而其他一些选项则在每次启动时读取。文件应该包含一个变量和用等号分隔的值的列表，每个变量对应一个值）

（配置文件中每一行一个变量，同JE服）

​        The following options are available. If a value as a number in parenthesis, that number can be used instead of the text value.

（以下选项是可用的。如果一个值在括号中是一个数字，那么这个数字可以用来代替文本值）     

| Option name（选项名称）         | Possible values（可选值）                                    | Default value（默认值）                      | When is it used（ 什么时候使用） | Notes                                                        |
| ------------------------------- | ------------------------------------------------------------ | -------------------------------------------- | -------------------------------- | ------------------------------------------------------------ |
| gamemode                        | survival (0), creative (1), adventure (2)                    | survival                                     | Always or only for new players   | 游戏模式：0生存、1创造、2冒险                                |
| difficulty                      | peaceful (0), easy (1), normal (2), hard (3)                 | easy                                         | Always                           | 游戏难度：0和平、1简单、2正常（普通）、3困难                 |
| level-type                      | FLAT, LEGACY, DEFAULT                                        | DEFAULT                                      | World creation                   | 世界类型：平坦、**（？）**、默认                             |
| server-name                     | Any string（任意字符串）                                     | Dedicated Server（默认为“Dedicated Server”） | Always                           | This is the server name shown in the in-game server list.（ 这是游戏内服务器列表中显示的服务器名称。） |
| max-players                     | Any integer（任何整数）                                      | 10（默认10人）                               | Always                           | The maximum numbers of players that should be able to play on the server. **Higher values have performance impact.**（ 能够在服务器上运行的最大玩家数量，较高的值会影响性能。） |
| server-port                     | Any integer                                                  | 19132                                        | Always                           | 服务器Ipv4端口，默认19132                                    |
| server-portv6                   | Any integer                                                  | 19133                                        | Always                           | Ipv6端口（PS：估计也没什么人用吧）                           |
| level-name                      | Any string                                                   | level                                        | Always                           | The name of level to be used/generated. Each level has its own folder in `/worlds`.（地图的名字，在目录`/worlds`下显示） |
| level-seed                      | Any string                                                   |                                              | World creation                   | The seed to be used for randomizing the world. If left empty a seed will be chosen at random.（ 用来随机化世界的种子。如果空着，种子将被随机选择。） |
| online-mode                     | true, false                                                  | true                                         | Always                           | If true then all connected players must be authenticated to Xbox Live.                    Clients connecting to remote (non-LAN) servers will always require Xbox Live authentication regardless of this setting.                    If the server accepts connections from the Internet, then it's **highly** recommended to enable online-mode. （ **联机模式**：如果值为true，那么所有连接的玩家都必须通过Xbox Live的认证。无论如何，连接到远程(非局域网)服务器的客户端都需要Xbox Live身份验证。如果服务器接受来自Internet的连接，那么强烈建议启用联机模式。） |
| white-list                      | true, false                                                  | false                                        | Always                           | If true then all connected players must be listed in the separate `whitelist.json` file.                            See the *Whitelist* section.（ **白名单**如果值为真，那么所有连接的玩家必须在白名单列表中`whitelist.json`。更多参见下面*Whitelist*小节。） |
| allow-cheats                    | true, false                                                  | false                                        | Always                           | 是否允许作弊                                                 |
| view-distance                   | Any integer                                                  | 10                                           | Always                           | The maximum allowed view distance. **Higher values have performance impact.**（**视距**： 允许的最大视距，较高的值会影响性能。） |
| player-idle-timeout             | Any integer                                                  | 30                                           | Always                           | After a player has idled for this many minutes they will be kicked. If set to 0 then players can idle indefinitely.（ **暂停时间**：当一个玩家暂停（摸鱼）了player-idle-timeout分钟后，他们将被踢。如果设置为0，那么玩家可以无限摸鱼（雾）。） |
| max-threads                     | Any integer                                                  | 8                                            | Always                           | Maximum number of threads the server will try to use.（ 服务器将尝试使用的**最大线程数**。） |
| tick-distance                   | An integer in the range [4, 12]（取值为4~12内的整数（PS：我看到了什么？？区间？高中数学必修一了解一手）） | 4                                            | Always                           | The world will be ticked this many chunks away from any player. **Higher values have performance impact.**（**区块卸载**：玩家加载的区块数超过此值将会被卸载，更高的值会留存更多的区块，所以较高的值会影响性能。（PS：这个不是很懂，请大佬解释）） |
| default-player-permission-level | visitor, member, operator                                    | member                                       | Always                           | Which permission level new players will have when they join for the first time.（ **默认玩家权限**：当新玩家第一次加入时，他们将拥的权限级别。观察者、玩家、管理员） |
| texturepack-required            | true, false                                                  | false                                        | Always                           | If the world uses any specific texture packs then this setting will force the client to use it.（ 如果开启，则会强迫客户端使用与服务端一样的纹理包） |

### Example `server.properties` file

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