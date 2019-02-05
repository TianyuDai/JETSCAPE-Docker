# Build Steps
1. Build the docker <br>
   `sudo docker build --tag <tag> <path to Dockerfile>`
2. Run the docker <br>
   `sudo docker run -it -v <local path>:<docker path> <tag>`<br>
    -`docker run` creates and starts a new docker container from a pre-defined image jdmulligan/jetscape-base:v1, which will be downloaded if necessary.
    - `-it` runs the container with an interactive shell.
    - `-v` mounts a shared folder between your machine (at ~/jetscape-user) and the container (at /home/jetscape-user), through which you can transfer files to and from the container. You can edit the location of the folder on your machine as you like.
    - `--name` (optional) sets a name for your container, for convenience. Edit it as you like.
    - `--user $(id -u):$(id -g)` (only needed on linux) runs the docker container with the same user permissions as the current user on your machine (since docker uses the same kernel as your host machine, the UIDs are shared). Note that the prompt will display "I have no name!", which is normal. 
3. Push the docker to the public <br>
   - `sudo docker tag <tag> <user>/<name>:<version>`
   - `sudo docker push <user>/<name>:<version>`
4. Then, the docker can be retrieved anywhere via `sudo docker run -it -v <local path>:<docker path> <user>/<name>:<version>`

# Docker on Nersc
1. Nersc uses shifter to conduct the docker: https://docs.nersc.gov/development/shifter/how-to-use/. 
2. Pull the image from dockerhub <br>
`shifterimg -v pull docker:<user>/<name>:<version>`
3. Check if the image is in the nersc image pool <br> 
`shifterimg images | grep '<user>'`
4. Pull the shifter on Nersc
`shifter --image=<user>/<name>:<version>`
5. Submit file should be editted as the example in `jetscape-basic`

# Tips
1. <workdir> is the location in docker space. It seems that we cannot set <workdir> under `/home`, or it may cause some permission errors. 
2. Using `git clone` in Dockerfile is tricky. I have iincluded an example here. I am not sure why does `ubuntu:latest` not work. I should study it further later. 
3. Once the docker is built, all the files copied in Dockerfile will be stored. Even though you change those files locally, the remote stored files should still be the same. 
