#!/bin/bash
source template/config.sh
pack build $image_name --path $src_folder_name -t $image --builder $builder
pid=$!
wait $pid

docker run -d -p $container_port:$container_port --rm --name $image_name $image_name
wait $pid

open "http://localhost:$container_port"
pid=$!
wait $pid

docker push $image
wait $pid

cd template
wait $pid

skaffold run --profile $profile
wait $pid

cd ..
pwd
cp -r template/k8 template/skaffold.yaml $src_folder_name
cp -r template/Jenkinsfile $src_folder_name

git clone https://github.com/Divyashet66/demo-network18.git

cp -r nodejs-todo/* demo-network18/
cd demo-network18/
pwd
git add -A
git status
git commit -m "initial commit"
git push 

