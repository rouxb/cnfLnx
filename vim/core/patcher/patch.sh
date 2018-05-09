#!/usr/bin/env bash
VIMPATH=`realpath "$( cd "$(dirname "$0")" ; pwd -P )"/../../`
### 
# Export autoload script in basedir and dein cache
################################################################################

### airline
repo_path=$VIMPATH/bundle/repos/github.com/vim-airline/vim-airline/autoload/airline/extensions/tabline/formatters
cache_path=$VIMPATH/bundle/.cache/init.vim/.dein/autoload/airline/extensions/tabline/formatters
mkdir -p  $repo_path
mkdir -p  $cache_path
# tabnr
custTabnr=core/patcher/customTabnr.vim
cp $VIMPATH/$custTabnr $repo_path
cp $VIMPATH/$custTabnr $cache_path

# tabName
custTabName=core/patcher/customTabName.vim
cp $VIMPATH/$custTabName $repo_path
cp $VIMPATH/$custTabName $cache_path
