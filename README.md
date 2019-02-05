# Build Steps
1. Build the docker
   `sudo docker build --tag <tag> <path to Dockerfile>`
2. Run the docker
   `sudo docker run -it -v <local path>:<docker path> <tag>`
   `docker run` creates and starts a new docker container from a pre-defined image jdmulligan/jetscape-base:v1, which will be downloaded if necessary.
    - `-it` runs the container with an interactive shell.
    - `-v` mounts a shared folder between your machine (at ~/jetscape-user) and the container (at /home/jetscape-user), through which you can transfer files to and from the container. You can edit the location of the folder on your machine as you like.
    - `--name` (optional) sets a name for your container, for convenience. Edit it as you like.
    - `--user $(id -u):$(id -g)` (only needed on linux) runs the docker container with the same user permissions as the current user on your machine (since docker uses the same kernel as your host machine, the UIDs are shared). Note that the prompt will display "I have no name!", which is normal.

# Tips
1. <workdir> is the location in docker space. It seems that we cannot set <workdir> under `/home`, or it may cause some permission errors. 
