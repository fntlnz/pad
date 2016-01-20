# PAD

The effort here is to write a tool that can parse php and provide an AST that can be useful when creating other tools like autocompletion daemons, static analyzers and so on.


At the moment PAD is just an empty CMake project with a flex lexer and a bison parser with which we are playing to figure out how to achieve our goal.

## Requirements

To play with this tool you need to have flex, bison and gcc, gcc-c++, make and cmake

Fedora/CentOS/Rhel

```
sudo dnf install -y gcc gcc-c++ flex bison cmake make
```

Debian/Ubuntu
```bash
sudo apt-get install -y flex bison g++ cmake make
```

## Build

```
cmake .
make
make pad
```

run ./bin/pad and see how this parser parse test.php file
