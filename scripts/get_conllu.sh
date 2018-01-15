#!/usr/bin/env bash

#parse given text file

if [[ -z $1 || -z $2  ]]; then
  echo 'Usage ' $0 ' <LANG_ID> <FILE_NAME>'
  exit 1
fi

__model=$1
__file=$2
__udpipe_server=127.0.0.1:8080

curl -F data=@${__file} -F model=${__model} -F tokenizer= -F tagger= -F parser= http://${__udpipe_server}/process | PYTHONIOENCODING=utf-8 python -c "import sys,json; sys.stdout.write(json.load(sys.stdin)['result'])"
