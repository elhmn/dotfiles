### Basic vim config

#### Installation ####

clone the repository
```
git clone repo_link local_repo_name
```

Add to your ~/.vimrc the folowing line
```
source local_repo_path/.vimrc
```

If you have no existing ~/.vimrc in your home
simply copy local_repo_path/.vimrc to your home directory
```
cp local_repo_path/.vimrc ~/
```

Then create a copy local_repo_path/.{vim, vimsrcs} to your hoeme directory
```
cp local_repo_path/.{vim, vimsrcs} ~/
```

Or create a symlink
```
ln -s local_repo_path/.{vimrc, vim, vimsrcs} ~/
```

Instal completion plugins :

- stern for js (make js)
- copy .stern-project to your home directory
