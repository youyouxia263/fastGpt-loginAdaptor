.PHONY: buildDocker

IMAGE?=login-page
TAG:=latest

buildDocker:
  npm install
  npm run build
  docker build ./ -t $(IMAGE):$(TAG) --push

runDocker:
   docker run -itd -p8080:80 --restart always --name login-page $(IMAGE):$(TAG)

rmDocker:
  docker rm -f login-page

stopDocker:
  docker stop login-page

startDocker:
  docker start login-page

reDeploy: buildDocker rmDocker runDocker
