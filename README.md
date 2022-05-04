# cfg
This is my dotfiles repo. It is pretty minimal right now (just used for bashrc, zshrc, tillix and neovim config).
It's always a WIP.

## Approach Used
I've used the git bare repo approach to backup my dot files. This allows me to have alll the files at the right place without having to think about symlinks or copying files.
This approach is explained more [here](https://www.atlassian.com/git/tutorials/dotfiles).


## Usage

Here's the final snippet. 
Use this snippet to get everything cloned to your system.

```bash
git clone --bare https://github.com/KaviiSuri/cfg.git $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
```

## Explaination 

### Aliases
Add the following alias in your bashfile. 
```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```
### Avoid Recursive Problems
Execute the following to ignore the bare repo created from git.
```bash
echo ".cfg" >> .gitignore
```

### Clone your dotfiles into a **bare** repo
```bash
git clone --bare <git-repo-url> $HOME/.cfg
```

### Checkout 
```bash
config checkout
```
This might give an error complaining about existing dot files. You may manually rename them to a {originalname}.backup file or do the following.

### Fix Config
This command will basically move every error causing file.
```bash
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```

### Checkout again
Checkout the files again
```bash
config checkout
```

### Stop showing all the files on the system!!!
By default, git shows you all the files if you do `git status`. This is useful normally, but in this use-case it'll be quite irritating to view everying in your `$HOME` folder.
Thus, it's better to ask git not to do this.
```bash
config config --local status.showUntrackedFiles no
```
