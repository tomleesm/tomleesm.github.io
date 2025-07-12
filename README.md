## 安裝

hugo

安裝 extended 版本，內建 SCSS 支援，才能使用 theme

https://github.com/gohugoio/hugo/releases 抓編譯好的檔案網址

``` bash
cd /tmp
wget https://github.com/gohugoio/hugo/releases/download/v0.128.2/hugo_extended_0.128.2_linux-amd64.tar.gz -O hugo.tar.gz
tar xf hugo.tar.gz
sudo cp hugo /usr/local/bin
vim ~/.bash_profile
# 加上 export PATH="$PATH:/usr/local/bin"
source ~/.bash_profile
hugo version
```

blog 和 theme

``` bash
mkdir -p ~/apps
git clone git@github.com:tomleesm/tomleesm.github.io.git ~/apps/blog
cd ~/apps/blog
git submodule update --init
hugo server
```
