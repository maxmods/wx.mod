# About wxMax

wxMax is a BlitzMax language binding for wxWidgets, a widget toolkit for 
creating graphical user interfaces (GUIs) for cross-platform applications.

It can be used to create full-featured GUI applications on Linux, MacOS and
Windows.


# Installing wxMax

On extracting the archive, you should have a folder called wx.mod
This contains the whole wxMax distribution, and should be placed in your
BlitzMax modules folder :
```
    BlitzMax/mod
```

## Build Requirements
To get up and running with wxWidgets, you will need to make sure your BlitzMax has access to some of the requirements for your platform of choice, as listed below :

### Windows
The wxWidgets static libraries have been compiled with MinGW-w64 7.2.0-rev1. Generally you should use the same version of MinGW as wxWidgets has been compiled with.
You can find the downloads for 32-bit and 64-bit builds here :
* x86 - https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/7.2.0/threads-posix/sjlj/i686-7.2.0-release-posix-sjlj-rt_v5-rev1.7z/download
* x64 - https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/7.2.0/threads-posix/seh/x86_64-7.2.0-release-posix-seh-rt_v5-rev1.7z/download

### Linux
TODO

### macOS
TODO

# Tutorials

There are some in-depth tutorials included with wxMax.
Look in the wx.mod/tutorials folder, and open index.html for access.

We are working on adding localized versions of the tutorials.


# Samples

As well as the tutorials, some larger samples are also provided to give you an
idea of the kind of complexity that wxMax is capable of.
You will find the samples in the wx.mod/samples folder.


# wxCodeGen

Since writing GUI-based applications can be complicated, special GUI editors
have been created to help you design your layouts graphically.

wxCodeGen is a tool provided with wxMax which can use project files created
by wxFormBuilder to generate a BlitzMax source framework for use in your
application.
This can often reduce the time taken to build a working prototype by many
orders of magnitude (from hours to minutes, for example).

You can find wxCodeGen in the wx.mod/tools folder.

# Links

~~BlitzMax      - http://blitzmax.com/~~

wxMax         - https://github.com/maxmods/wx.mod

~~wxMax Forum   - http://blitzmax.com/Community/topics.php?forum=124~~

wxWidgets     - http://wxwidgets.org/

wxFormBuilder - http://wxformbuilder.org/
