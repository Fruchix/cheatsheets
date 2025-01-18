# cheatsheets

> A CLI bash tool that lets you navigate through your cheatsheets using fzf.

After adding this directory to your path, you'll be able to call `cheasheets` from your terminal and search through this list of cheatsheets. You can use multiple keywords, that will be searched in the subfolders name, the file names and the `KEYWORDS` line of each cheatsheet.

It currently is mainly for my cheatsheets, but one can fork this repository and add its own cheatsheets.

## Requirements

- `bash >= 4`
- `find`
- `grep`
- `fzf`
- `bat` (currently required, will be optional in the future)

Specifics to build the bash bible cheatsheets:
- `pandoc`
- `wget`
The bash bible cheatsheets will be commited to this repository in the future, the script is mainly there to be able to rebuild them easily.

## Installation

Clone this repository:
```sh
git clone https://github.com/Fruchix/cheatsheets.git
```

And add the directory to the PATH:
```sh
export PATH="$PATH:/path/to/cheatsheets/"
```

Optional steps: execute the `build_bash_bible_cheatsheets.sh` script to be able to search through the [bash bible](#bash-bible-cheatsheets).

## Usage

Use `cheatsheets` in your terminal to access the cheatsheets, then begin searching by typing keywords! Those keywords are not searched within the content of all cheatsheets, only in the folder name, file name and in the `KEYWORDS` line of each cheatsheet.

While inside `cheatsheets`:
- `enter`: use `cat` to print the selected cheatsheet in the terminal
- `ctrl-p`: use `bat` to pretty print the selected cheatsheet in the terminal
- `ctrl-b`: toggle on and off the search inside the `bash-bible` directory (see [Bash Bible Cheatsheets](#bash-bible-cheatsheets))

## Writing a cheatsheet

Here are the required rules to write a cheatsheet that can be used by the search engine:
- each cheatsheet should have a unique name, even in different different sub-folders.
- the name convention is `<LANGUAGE>-<custom_name>.chsht.<extension>`, e.g. `PYTHON-list_basics.chsht.py`.

The reason for the unique name is that only the filename is displayed in fzf (for pretty purpose), then used to find the file back.
This behaviour might change in the future if preventing duplicate names becomes a liability.

Here are the optional rules:
- add a single commented line containing `KEYWORDS: <keyword1> <keyword2> <keyword3> ...`, e.g. `# KEYWORDS: array list index slice count`.
- add a single paragraph of commented lines beginning with `REFERENCES: `, containing links, advice or even thoughts.

An example of a valid cheatsheet:

`PYTHON-list_basics.chsht.py`
```py
# KEYWORDS: array list index slice count len length add remove push pop delete replace

# REFERENCES:
# https://www.w3schools.com/python/python_lists.asp
# https://www.codecademy.com/learn/dacp-python-fundamentals/modules/dscp-python-lists/cheatsheet
# 
# this comment is still part of the "REFERENCES" paragraph

# this comment is not part of the "REFERENCES" paragraph
```

## Bash Bible Cheatsheets

The `pure bash bible` is an archived collection of pure bash alternatives to external processes.

> https://github.com/dylanaraps/pure-bash-bible

The script `build_bash_bible_cheatsheets.sh` parses the pure bash bible into cheathsheets, all stored into the `bash-bible` directory. This directory is not included in the search by default, but can be included by pressing `ctrl-b`.

A known limitation is that there is no custom `KEYWORDS` line for each file, meaning that `cheatsheets` will only search in the folder and file names.

See [requirements](#requirements) for the bash bible parsing requirements.
