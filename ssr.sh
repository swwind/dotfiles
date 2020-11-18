#!/bin/zsh

if [ ! -d shadowsocksr ]; then
  git clone -b manyuser --depth=1 https://github.com/shadowsocksr-backup/shadowsocksr.git
fi

help() {
  cat ssr-help.txt
}

if [ $# = 0 ]; then

  help

elif [ $1 = "start" ]; then

  cd shadowsocksr/shadowsocks
  sudo python local.py -d start

elif [ $1 = "stop" ]; then

  cd shadowsocksr/shadowsocks
  sudo python local.py -d stop

elif [ $1 = "sub" ]; then

  echo -n "sub link: "
  read fuck

  curl -fsSL $fuck | node ssr.js

  echo -n "select a node: "
  read node
  mv shadowsocksr/config.$node.json shadowsocksr/config.json

elif [ $1 = "destruct" ]; then

  rm -rf shadowsocksr

fi
