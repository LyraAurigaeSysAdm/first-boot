How to make a proper .packagelist file
======================================

# Intro
The `.packagelist` file doesn't exist. it's just a simple package list format that accept comment a package.

# Structure

Each line of the `.packagelist` should containe one packagename.
For instance we could have:
```
nano
openssh-server
```
As said earlier, a `.packagelist` file can accept comment, as shown in the example below
```
# This is the text editor
nano
# This is the ssh server
open-ssh
```