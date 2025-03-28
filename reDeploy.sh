IMAGE=login-page
TAG=latest
git pull
npm install
npm run build
docker build ./ -t $IMAGE:$TAG 
docker rm -f login-page
docker run -itd -p8080:80 --restart always --name login-page $IMAGE:$TAG
