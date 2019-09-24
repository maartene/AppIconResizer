# AppIcon Resizer
A simple CLI tool to convert an input PNG into all the required formats for iOS. Like launch icons, settings icons, spotlight, etc. In all the required formats for iPad, iPad Pro, iPhone, 2x, 3x etc. Should save you some time.

## Build instructions
This is a little cumbersome. After building, you will have an executable somewhere in a temporary folder. Or you can create an archive and find it there. Once you find it, you can "install" it by copying it to a location within path. For example:
`# sudo cp appiconresizer /usr/local/bin/`

### Usage
Use: `# appiconresizer <inputfile>`
Example: 
  ```# appiconresizer icon.png
  # ls -l
  -rw-r--r--@ 1 maartene  staff  1047358 24 sep 19:30 icon.png
  -rw-r--r--@ 1 maartene  staff  1945292 24 sep 19:58 icon.pxm
  -rw-r--r--  1 maartene  staff  1281021 24 sep 19:30 icon_1024x1024.png
  -rw-r--r--  1 maartene  staff    22589 24 sep 19:30 icon_120x120.png
  -rw-r--r--  1 maartene  staff    34876 24 sep 19:30 icon_152x152.png
  -rw-r--r--  1 maartene  staff    41234 24 sep 19:30 icon_167x167.png
  -rw-r--r--  1 maartene  staff    48156 24 sep 19:30 icon_180x180.png
  -rw-r--r--  1 maartene  staff     1035 24 sep 19:30 icon_20x20.png
  -rw-r--r--  1 maartene  staff     1830 24 sep 19:30 icon_29x29.png
  -rw-r--r--  1 maartene  staff     3208 24 sep 19:30 icon_40x40.png
  -rw-r--r--  1 maartene  staff     5995 24 sep 19:30 icon_58x58.png
  -rw-r--r--  1 maartene  staff     6463 24 sep 19:30 icon_60x60.png
  -rw-r--r--  1 maartene  staff     9813 24 sep 19:30 icon_76x76.png
  -rw-r--r--  1 maartene  staff    10690 24 sep 19:30 icon_80x80.png
  -rw-r--r--  1 maartene  staff    12432 24 sep 19:30 icon_87x87.png
```
 
### Other commandline options
* `-o <directory> ` : specify an output directory (where the generated files are stored)
* `-v             ` : show version information
* `-h             ` : show help
