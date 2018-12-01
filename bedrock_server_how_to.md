# How to use the dedicated server

> **翻译**：MilkMC服务器-Hailay
>
> **鸣谢**：**MilkMC管理与建设群** 的各位提出的建议
>
> PS：请尊重作者几个小时的劳动，转载请著名出处，谢谢！
>
> PS2：英文原文为`BDS-1.7.0.13`服务端中的`bedrock_server_how_to.html`文件，本文在英文原文下给出中文翻译。由于译者水平有限,本翻译错漏在所难免,恳请各位看官批评指正！指正方式：Github
>
> PS3：先声明，有些地方实在是译者也不理解，如果读者按照我的理解在服务器中做出不可挽回的损失，这与作者无关！请自行试验过服务端再运行与生产环境。
>
> **协议**： CC BY-NC-ND 3.0 CN
> <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/3.0/cn/"><img alt="知识共享许可协议" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/3.0/cn/88x31.png" /></a><br />本作品采用<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/3.0/cn/">知识共享署名-非商业性使用-禁止演绎 3.0 中国大陆许可协议</a>进行许可。
>
> 2018.12.1 Sunday 晚，Hailay于 Guangzhou。

## Disclaimer(免责声明)

    This is an early release (alpha) which we don't fully support yet. It might contain severe issues and we could stop supporting it at any time. 

（这是一个我们还没有完全支持的早期版本(alpha)。它可能包含严重的问题，我们可以在任何时候停止支持它。）    

## Platforms（平台）

### Linux

    Unzip the container file into an empty folder. Start the server with the following command:     

（将容器文件解压缩到空文件夹中，使用以下命令启动服务器：）

```
LD_LIBRARY_PATH=. ./bedrock_server 
```



### Windows

​        Unzip the container file into an empty folder. Start the server by executing the `bedrock_server.exe` file.   

（将容器文件解压缩到空文件夹中，通过执行`bedrock_server.exe` 文件启动服务器。）  

​        On some systems, when you wish to connect to the server using a client running on the same machine as the server is running on, you will need to exempt the Minecraft client from UWP loopback restrictions:  

（在某些系统上，当您希望使用运行在与服务器相同机器上的客户端连接到服务器时，您需要去除Minecraft客户端受UWP回路限制）        

```
CheckNetIsolation.exe LoopbackExempt –a –p=S-1-15-2-1958404141-86561845-1752920682-3514627264-368642714-62675701-733520436
```



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
| default-player-permission-level | visitor, member, operator                                    | member                                       | Always                           | Which permission level new players will have when they join for the first time.( **默认玩家权限**：当新玩家第一次加入时，他们将拥的权限级别。观察者、玩家、管理员) |
| texturepack-required            | true, false                                                  | false                                        | Always                           | If the world uses any specific texture packs then this setting will force the client to use it.（ 如果开启，则会强迫客户端使用与服务端一样的纹理包） |

### Example `server.properties` file（例子）

 ```yaml
    server-name=Dedicated Server
    gamemode=survival
    difficulty=easy
    allow-cheats=false
    max-players=10
    online-mode=true
    white-list=false
    server-port=19132
    server-portv6=19133
    view-distance=10
    tick-distance=4
    player-idle-timeout=30
    max-threads=8   
 ```

   

## Folders

    When unpacking you will see a few folders and the binary executable. When starting the server for the first time a bunch of new (empty) folders will be created. The folders you should care about are the following: 

（解压时，您将看到一些文件夹和二进制可执行文件。当首次启动服务器时，将创建一些新的(空的)文件夹。您应该关心的文件夹如下：）    

| Folder name（文件夹名） | Purpose（目的）                                              |
| ----------------------- | ------------------------------------------------------------ |
| behavior_packs          | This is where new behavior packs can be installed. At the moment there's no way of activating  them in a level.（ 这里可以安装新的行为包，目前还没有办法激活它们。（PS：没用，干嘛要放在这QAQ）） |
| resource_packs          | This is where new resource packs can be installed. At the moment there's no way of activating them in a level.（资源包，也暂时不可用） |
| worlds                  | This folder will be created at startup if it doesn't already exist. Every world created will have a folder named according to their `level-name` inside the `server.properties` file.（ 如果这个文件夹不存在，它将在启动时创建。创建的每个世界都将在服务器中有一个根据`server.properties`的`level-name`变量命名的文件夹。） |

## Whitelist （白名单）

​        If the `white-list` property is enabled in `server.properties` then the server will only allow selected users to connect. To allow a user to connect you need to know their Xbox Live Gamertag. The easiest way to add a user to the whitelist is to use the command `whitelist add <Gamertag>` (eg: `whitelist add ExampleName`). Note: If there is a white-space in the Gamertag you need to enclose it with double quates: `whitelist add "Example Name"`   

（如果配置文件 `server.properties` 中启用了 `white-list` ，则服务器只允许白名单内的用户连接服务器。要让用户连接，你需要知道他们的Xbox Live Gamertag（就是Xbox Live的游戏id）。将用户添加到白名单最简单的方法是使用命令 `whitelist add <Gamertag>` (例如: `whitelist add ExampleName`)。注意:如果Gamertag中有空格，则需要用英文双引号将其括起来: `whitelist add "Example Name"`  ）  

​        If you later want to remove someone from the list you can use the command `whitelist remove <Gamertag>`.     

（如果以后想从白名单中删除某人，可以使用 `whitelist remove <Gamertag>`命令。）

​        The whitelist will be saved in a file called `whitelist.json`. If you want to automate the process of adding or removing players from it you can do so. After you've modified the file you need to run the command `whitelist reload` to make sure that the server knows about your new change.     

（白名单将被保存在一个名为 `whitelist.json`的文件中。如果你想要自动添加或删除玩家，你可以修改这个文件（方法如下）。修改文件后，需要运行命令 `whitelist reload` 重载，以确保服务器知道您的新更改。）

​        The file contains a JSON array with objects that contains the following key/values.     （该文件包含一个JSON数组，对象包含以下键/值。（PS：作者对此不是很懂，有误请指出））

| Key                | Type    | Value                                                        |
| ------------------ | ------- | ------------------------------------------------------------ |
| name               | String  | The gamertag of the user.（必填。玩家名）                    |
| xuid               | String  | Optional. The XUID of the user. If it's not set then it will be populated when someone with a matching name connects.（ 可选的。如果没有设置，那么当具有匹配名称的人连接时将自动填充。） |
| ignoresPlayerLimit | Boolean | True if this user should not count towards the maximum player limit. Currently there's another soft limit of 30 (or 1 higher than the specified number of max players) connected players, even if players use this option. The intention for this is to have some players be able to join even if the server is full.( **忽略玩家最大数限制**：如果该用户不应计入最大玩家限制，则为True。目前还有一个软限制，即连接的玩家数量为30(或比指定的最大玩家数量多1个)，即使玩家使用这个选项也没有用。这样做的目的是让一些玩家能够在服务器已满时加入。) |

​        Example `whitelist.json` file:     

```json
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

（  您可以通过在`permissions.json` 中分配玩家的特定权限。这个文件被放置在与服务器可执行文件相同的目录中。该文件包含一个具有xuid和权限的简单JSON对象。有效权限有: `operator`, `member`, `visitor`。如果在服务器运行时更改此文件，则运行命令`permissions reload` ，以确保服务器知晓您的新更改。您还可以使用指令 `permissions list`列出当前权限。注意，由于xuid需要对用户帐户进行在线验证，因此需要启用联机模式才能使该特性发挥作用。如果未在此列表中的新玩家连接，将应用配置文件中 `default-player-permission-level` 选项。）

​        Example `permissions.json` file:     

```json
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

（如果服务器崩溃，它会自动给发送我们多种信息来帮助我们在未来解决它们。）

## Commands （命令）

​        You can issue commands to the server by typing in the console. The following commands are available. < > means a parameter is required, [ ] means it's optional and | denotes different allowed values. Strings can be enclosed in double quotes, ", if they contain spaces.     

（您可以通过在控制台输入命令控制服务器，下面表格是可用的指令集。`< >`表示需要一个参数，`[]`表示它是可选的，|表示不同的允许值。如果它们包含空格，字符串可以用`双引号`括起来。）

| Command syntax（命令语法）              | Description （介绍）                                         |
| --------------------------------------- | ------------------------------------------------------------ |
| kick <player name or xuid> <reason>     | Immediately kicks a player. The reason will be shown on the kicked players screen.（ 立即踢出该玩家，原因将显示在被踢玩家的屏幕上。） |
| stop                                    | Shuts down the server gracefully.（ 优雅地关闭服务器。）     |
| save <hold \| resume \| query>          | Used to make atomic backups while the server is running. See the backup section for more information.（ 用于在服务器运行时进行精确的备份。有关更多信息，请参见备份部分。） |
| whitelist <on \| off \| list \| reload> | `on` and `off` turns the whitelist on and off. Note that this does not change the value in the `server.properties` file!                     `list` prints the current whitelist used by the server                     `reload` makes the server reload the whitelist from the file.                                             See the Whitelist section for more information.（ `on`和`off`表示打开和关闭白名单。注意，这不会改变配置文件`server.properties`中的值!`list` 输出白名单列表，`roload`使服务器从文件中重新加载白名单。有关更多信息，请参见白名单部分。） |
| whitelist <add \| remove> <name>        | Adds or removes a player from the whitelist file. The name parameter should be the Xbox Gamertag of the player you want to add or remove. You don't need to specify a XUID here, it will be resolved the first time the player connects.See the Whitelist section for more information.（ 从白名单文件中添加或删除玩家。<name>参数应该是要添加或删除的播放器的Xbox Gamertag。您不需要在这里指定XUID，它将在玩家第一次连接时自动填输。有关更多信息，请参见白名单部分。） |
| ops <list \| reload>                    | `list` prints the current used operator list.                     `reload` makes the server reload the operator list from the ops file.  See the Whitelist section for more information.（`list` 打印当前的管理员列表。`reload`重新加载管理员列表文件。有关更多信息，请参见白名单部分。） |
| changesetting <setting> <value>         | Changes a server setting without having to restart the server. Currently only two settings are supported to be changed, `allow-cheats` (true or false) and `difficulty` (0, `peaceful`, 1, `easy`, 2, `normal`, 3 or `hard`). They do not modify the value that's specified in `server.properties`.（ 更改服务器游戏模式而无需重新启动服务器。目前只支持更改作弊和游戏难度，可选项如上。） |

## Backups （备份）

​        The server supports taking backups of the world files while the server is running. It's not particularly friendly for taking manual backups, but works better when automated. The backup (from the servers perspective) consists of three commands.     

（服务器支持在服务器运行时备份世界文件。它对于手动备份不是特别友好，但是在自动备份时工作得更好。备份(从服务器的角度来看)由三个命令组成。）

| Command（指令） | Description（介绍）                                          |
| --------------- | ------------------------------------------------------------ |
| save hold       | This will ask the server to prepare for a backup. It’s asynchronous and will return immediately.（ 这将要求服务器准备备份。它是异步的，将立即返回。） |
| save query      | After calling `save hold` you should call this command repeatedly to see if the preparation has finished. When it returns a success it will return a file list (with lengths for each file) of the files you need to copy. The server will not pause while this is happening, so some files can be modified while the backup is taking place. As long as you only copy the files in the given file list and truncate the copied files to the specified lengths, then the backup should be valid.（ 在调用save hold之后，应该反复在控制台输入这个命令，看看准备是否已经完成。当它返回成功时，它将返回需要复制的文件列表(每个文件的大小)。发生这种情况时，服务器不会暂停，因此可以在备份时修改一些文件。只要您只复制给定文件列表中的文件并将复制的文件截断到指定的大小，那么备份应该是有效的。（PS：？？？不理解的说）） |
| save resume     | When you’re finished with copying the files you should call this to tell the server that it’s okay to remove old files again.（ 当您复制完文件后，应该调用这个函数告诉服务器可以再次删除旧文件。） |