<div align="center">

![JSON for LuaRT][title] 

[![LuaRT module](https://badgen.net/badge/LuaRT/module/yellow)](https://www.luart.org/)
![Windows](https://badgen.net/badge/Windows/10%20and%20later/blue?icon=windows)
[![LuaRT license](https://badgen.net/badge/License/MIT/green)](#license)
[![Twitter Follow](https://img.shields.io/twitter/follow/__LuaRT__?style=social)](https://www.twitter.com/__LuaRT__)

[Features](#small_blue_diamondfeatures) |
[Installation](#small_blue_diamondinstallation) |
[Usage](#small_blue_diamondusage) |
[Documentation](https://www.luart.org/doc/webview/index.html) |
[License](#small_blue_diamondlicense)

</div>
   
## :small_blue_diamond:Features

- JSON binary module for LuaRT
- Decode JSON string representation to Lua value
- Encode Lua value to JSON string representation
- Based on zzzJSON, one of the fastest C JSON implementation
  
## :small_blue_diamond:Installation

#### Method 1 : JSON module release package :package:

The preferred way to get the JSON module is to download the latest release package available on GitHub.
Just unpack the downloaded archive to get the `Json.dll` LuaRT binary module.
  
#### Method 2 : JSON module from sources :gear:

All you need to build the JSON module from sources is a valid installation of the Mingw-w64 distribution (actually tested using GCC 8.1 and GCC 12+), feedback is welcome for other C/C++ compilers.

First clone the JSON module repository (or manualy download the repository) :
```
git clone https://github.com/samyeyo/Json.git
```

Then go to the root directory of the repository and type ```make```:

```
cd Json\
make
```
It will try to autodetect the LuaRT path, and if it failed, you can still set the `LUART_PATH` directory in the Makefile.
If everything went right, it will produce the `Json.dll` LuaRT binary module.

## :small_blue_diamond:Usage
The LuaRT module can be used by any LuaRT interpreter, either `luart.exe` or `wluart.exe`
To use the LuaRT module in your applications, just require for the `json` module to load it :
```
local json = require "json"
```
The `json.dll` binary module must be in the same directory as the Lua script that loads it, or in the current `LUA_CPATH`

Once loaded, the Json module can be used :
```lua
local json = require "json"

-- json.encode() : encode a Lua value to JSON string representation
json.encode({ "Hello", "World", { name = "LuaRT" } }) -- Returns '["Hello", "World", {"name": LuaRT} ]'

-- json.decode() : decode a JSON string representation to a Lua value
local data = json.decode('["Hello", "World", {"name": LuaRT} ]')
print(data[3].name) -- Prints LuaRT
```
  
## :small_blue_diamond:Documentation
  
- :book: [JSON for LuaRT Documentation](http://www.luart.org/doc/json.html)
  
## :small_blue_diamond:License
  
Webview for LuaRT is copyright (c) 2022 Samir Tine.
Webview for LuaRT is open source, released under the MIT License.

See full copyright notice in the LICENSE file.

[title]: contrib/Webview.png