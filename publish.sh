docker build -t wenkaifan/jetscape:latest .
docker rm $(docker ps -a -f status=exited -q)
docker run --name jetscape-comp wenkaifan/jetscape:latest
docker commit jetscape-comp wenkaifan/jetscape
docker push wenkaifan/jetscape
