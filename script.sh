#!/usr/bin/env bash

dc=("centos7" "pycontribs/centos:7" "ubuntu" "pycontribs/ubuntu" "fedora_new" "pycontribs/fedora")

docker_run(){
   ar=("$@")
   ind=0
   while [ $ind -lt ${#ar[@]} ]
   do
      docker run --name ${ar[$ind]} -d --rm ${ar[$ind+1]} sleep 7200
      (( ind+=2 ))
   done
}

docker_stop(){
   ar=("$@")
   ind=0
   while [ $ind -lt ${#ar[@]} ]
   do
      docker stop ${ar[$ind]}
      (( ind+=2 ))
   done
}

docker_run "${dc[@]}"

ansible-playbook -i inventory/prod.yml site.yml --vault-pass-file $ANS_VLT_FILE

docker_stop "${dc[@]}"
