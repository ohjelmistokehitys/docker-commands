# Docker commands

In this exercise, you will create a Docker container and practise running basic commands both inside the container and on the host system. In the first phase, you will create a container and install dependencies in it using basic commands. In the second phase, you will create a Dockerfile to automate the process of creating a container with the necessary dependencies already installed. You will also learn how to run commands inside the container and how to use the Docker CLI to manage containers.

In production environments, you won't typically run commands interactively, as setting up and maintaining containers is typically automated using Dockerfiles and container orchestration tools. However, to learn how to achieve the automation and to investigate issues with your containers, it is important to understand some basics.

> [!WARNING]
> This exercise requires some understanding of command line interfaces and Linux commands. Incorrect use of commands will lead to unexpected results, so please make sure you understand what each command does before running it.
>
> Also, make sure that you are always running commands in the correct context: either inside the Docker container or on the host system. Running commands in the wrong context leads to confusion and errors.
>
> If you are unsure about a command, please consult the documentation and discuss it with your peers or instructors before proceeding. As a general rule, official images from Docker Hub are widely used and well documented and their security is well established. However, you should always be cautious when using third-party images or running commands that you are not familiar with.
>
> *"The Docker Official Images team ultimately acts as a gatekeeper for all changes, which helps ensures consistency, quality, and security."* [(Docker Official Images, docker.com)](https://docs.docker.com/docker-hub/repos/manage/trusted-content/official-images/)


## Prerequisites

Before starting this exercise, you should have Docker either installed on your system or be using a cloud service that provides a Docker runtime environment. Verify that you can run the `docker` command in your terminal. You can check this by running the following command:

```bash
docker --help
```

If you see a list of Docker commands and options, you are ready to proceed. If not, please refer to the [Docker installation guide](https://docs.docker.com/get-docker/) for instructions on how to install Docker on your system.


## How to complete this exercise

First, make sure you are working on your personal copy of the repository. You can find more information about that in the course assignment. Complete the exercises while reading the course materials and the [Docker documentation](https://docs.docker.com/). You will also need to read the documentation for specific containers and commands used in the exercises.

Copy the outputs or the commands you use based on the instructions in individual steps. Commit and push your solutions to your repository to invoke the automated grading. You can and should commit your solutions after each step to keep track of your progress and to make it easier to debug any issues that may arise. The automated grading will check your solutions and provide feedback on your progress.

Automated grading is implemented using GitHub actions and GitHub classroom. After each commit, you can see the autograding results as well as each test and their outputs in the *actions* tab under *Classroom Autograding Workflow*. You can push new solutions as many times as necessary until the deadline of the exercise.


## Task: using basic Linux commands inside a Docker container

In this exercise, you will use a Docker container to run basic Linux commands. The goal is to familiarize yourself with running commands inside a container, installing dependencies, and filtering text files. You will also learn how to use the Docker CLI to manage containers.

Your task starts with the following email from a colleague:

> From: Alice<br />
> Subject: Help with syslog errors
>
> Hey, could you take a quick look at the latest system logs from our office server?
>
> I've been seeing some weird behavior from docker, sshd and our office IoT devices recently. I suspect there might be some errors or critical messages from those services, but I don't have the tools or knowhow to access or filter the logs.
>
> Can you help me out and filter all CRITICAL messages from the logs that and sort them by the time they were logged? I hope this would help us identify any issues with our system.
>
> No need to overprocess - I'm mainly trying to get a sense of what's going on.
>
> Thanks! 🙏

The log file you need to analyze can be found at https://ohjelmistokehitys.github.io/docker-commands/syslog.txt. As Linux has many powerful tools for processing text files, you choose to use a Docker container to run the commands you need. This way, you can easily install the necessary tools and run the commands and you will be able to share the complete solution with your colleague to also reduce the amount of similar requests in the future.

The commands for downloading, filtering and sorting the logs are provided below in each step. The focus of the exercise is on operating a Docker container and running commands inside it, rather than on the specific commands used inspecting the logs.


## Part 1: create a container

To complete this part of the exercise, you will create a Docker container with basic Linux capabilities. We recommend using the [latest official `ubuntu` image](https://hub.docker.com/_/ubuntu), but you are free to choose any other image that suits your needs. Example commands and instructions are provided for the `ubuntu` image.

First, create a new Docker container by running the following command in your terminal:

```bash
# Create a new Docker container with the latest Ubuntu image:
docker container run --interactive --tty --name syslogs ubuntu

# There are several ways to shorten the commands, for example
# the following command is equivalent to the one above:
docker run -it --name syslogs ubuntu
```

> The `run` command is documented in the [Docker CLI documentation](https://docs.docker.com/reference/cli/docker/container/run/).
>
> The `--interactive` or `-i` option lets you [send input to the container through standard input](https://docs.docker.com/reference/cli/docker/container/run/#interactive).
>
> The `--tty` or `-t` option [connects your terminal to the I/O streams of the container](https://docs.docker.com/reference/cli/docker/container/run/#tty).
> # "--name" option gives the container a name, in this case "syslogs".
>
> The --name flag [lets you specify a custom identifier for a container](https://docs.docker.com/reference/cli/docker/container/run/#name).

The first time you run the command, Docker will download the latest Ubuntu image from the Docker Hub. After that, it will create a new container named `syslogs` and start it. You will see a command prompt inside the container, which indicates that you are now working inside the container:

```
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
0622fac788ed: Pull complete
Digest: sha256:6015f66923d7afbc53558d7ccffd325d43b4e249f41a6e93eef074c9505d2233
Status: Downloaded newer image for ubuntu:latest

root@19fdcbb2a4f6:/#
```

You can now interact with the container as if it were a regular Linux system. The command prompt indicates that you are logged in as the `root` user inside the container, which is the default user for many Docker images. Using the `root` user inside a container is common, as it allows you to install packages and run commands without restrictions and without the `sudo` command. However, be cautious when running commands as `root`.


## Part 2: list, stop and start containers

Now that you have created and started a new container, you can manage it using the Docker CLI. To use the Docker CLI, you need to open a new terminal window or tab on your host system (not inside the container).

In this new terminal, you can run commands to manage your containers. First, start by listing all **running** containers:

```bash
docker container ls

# or the short version
docker ps
```

**Save the output** of the command to the file [`list-running-containers.txt`](./list-running-containers.txt) in your repository and **commit** the changes. Make sure the `syslogs` container is listed in the output. You can also direct the output to the file directly by using the `>` operator:

```bash
# you can apply this approach to the following commands as well
docker ps > list-running-containers.txt
```

Next, **stop** the `syslogs` container by running the following command in the terminal on your host system:

```bash
docker container stop syslogs

# or the short version
docker stop syslogs
```

Now, if you run the `docker ps` command again, you will not see the `syslogs` container, as it is stopped. To see all containers, including the stopped ones, use the `--all` or `-a` option:

```bash
docker container ls --all

# or the short version
docker ps -a
```

You should now see the `syslogs` container with an `Exited` status.

**Save the output** of the command to the file [`list-all-containers.txt`](./list-all-containers.txt) in your repository and **commit** the changes.


## Part 3: starting and attaching to containers

Now that the `syslogs` container is stopped, you can start it again by running the following command in the terminal on your host system:

```bash
docker container start syslogs

# or the short version
docker start syslogs
```

The container will start, but you will not see the command prompt inside the container, as you are still in the terminal on your host system. To attach to the running container and see the command prompt inside it, you need to **attach** to the container:

```bash
docker container attach syslogs

# or the short version
docker attach syslogs
```

Now you are back in business and can start investingating the logs, but first you need to install a tool for downloading the logs from the internet.


## Part 4: install dependencies (curl)

Installing apps and running commands inside the container is very similar to running commands on any Linux system. In this case, when we need to download a file from the internet, we can use the `curl` command. The `curl` command is [a tool to transfer data from a server](https://curl.se/). Although `curl` is among the most commonly used tools in Linux, it is not installed by default in the `ubuntu` Docker image. Therefore, you need to install it first.

To install dependencies, you can use the package manager of the Linux distribution you are using in the container. In the case of Ubuntu, you can use `apt` to install packages. As with any Ubuntu instance, you need to update the package list before installing new packages. Run the following commands inside the container:

```bash
# update the package list
apt update

# install curl
apt install curl

# or, if you want to install curl without any prompts:
apt install -y curl
```

> [!NOTE]
> Unlike traditional Ubuntu installations, the default Ubuntu image uses `root` as the default user, there is no need to use or include the `sudo` command in the image.

Now that you have `curl` installed, you can use it to download the log file from the internet. Run the following command inside the container:

```
curl https://ohjelmistokehitys.github.io/docker-commands/syslog.txt
```

You should see a long output of log messages and timestamps in the terminal. This is the content of the log file you need to analyze to figure out why the server is behaving strangely. The log file contains messages from various services and going through it manually would be tedious. Instead, use existing tools to filter and sort the messages.


## Part 5: filter and sort logs

In the email from your colleague, you were asked to filter out all *CRITICAL* messages from the logs and sort them by the time they were logged. You can use the `grep` command to filter the messages and the `sort` command to sort them.

You can use the `grep` and `sort` commands to pipe the output of the `curl` command directly, without saving it to a file first. [`grep` is a command-line utility for searching plain-text data for lines that match a regular expression](https://en.wikipedia.org/wiki/Grep), and [`sort` is a command-line utility for sorting lines of text files](https://en.wikipedia.org/wiki/Sort_(Unix)).

Run the following command inside the container:

```bash
curl https://ohjelmistokehitys.github.io/docker-commands/syslog.txt | grep "CRITICAL" | sort
```

Now you should see just a few lines of output, which contain enough information for you to identify the most critical ongoing issues with the server. You will just need to save the output to a file so that you can share it with your colleague. Run the command again, but this time redirect the output to a file named `/tmp/filtered-sorted-logs.txt`:

```bash
# direct the output to a file:
curl https://ohjelmistokehitys.github.io/docker-commands/syslog.txt | grep "CRITICAL" | sort > /tmp/syslog-critical.txt

# verify that the file was successfully created:
cat /tmp/syslog-critical.txt
```

## Part 6: copy files between host and container

Now the file is created inside the container and you have no way to access it from the host system. To copy files between the host system and the container, you can use the [`docker cp` command](https://docs.docker.com/reference/cli/docker/container/cp/). This command allows you to copy files or directories between a container and the local filesystem.

In the `docker cp` documentation, there is [an example of copying a file from a container to the host system](https://docs.docker.com/reference/cli/docker/container/cp/#examples):

```bash
docker cp CONTAINER:/var/logs/ /tmp/app_logs
```

In our case, the container is named `syslogs` and the file is located at `/tmp/syslog-critical.txt`. Next we want to copy it to the current directory on the host system with the same name. To do this, you can run the following command in the terminal on your host system (not inside the container):

```bash
docker cp syslogs:/tmp/syslog-critical.txt ./syslog-critical.txt
```

You can now verify that the file was successfully copied by opening the [`syslog-critical.txt`](./syslog-critical.txt) file in your text editor. You should see the filtered and sorted log messages that you created inside the container, which you could then share with your colleague. Perhaps even discuss with them whether powering coffee warmers from the server's USB ports is a good idea or not.

Make sure to commit the changes in `syslog-critical.txt` file to your repository.


## Part 7: create a Dockerfile

Finally, as you have successfully created a container and installed the necessary dependencies, you can automate the process of creating a container with the required tools already installed, which allows you to share the solution in either source code or as a pre-built Docker image. This way, you can easily share the solution with your colleague or use it in other projects without having to manually install the dependencies every time.

The creation of Docker images can be automated using a [`Dockerfile`, which is a text file that contains instructions for building a Docker image](https://docs.docker.com/reference/dockerfile/).

Make use of the [Dockerfile documentation](https://docs.docker.com/reference/dockerfile/) as well as the course materials to create a `Dockerfile` that meets the following requirements:

* The Dockerfile should preferably use the latest official `ubuntu` image as the base image. Use other images if you know what you are doing.
* The Dockerfile should update the package list and install the `curl` package using the `apt` package manager.
* The Dockerfile should copy the [`process-logs.sh`](./process-logs.sh) script to the `/usr/local/bin/` directory in the container. This script contains the previous `curl`, `grep` and `sort` commands, so you don't need to write them again.
* Make sure that the `process-logs.sh` script is executable by running `chmod +x /usr/local/bin/process-logs.sh` in the Dockerfile.

Use the `COPY` and `RUN` commands in the Dockerfile to achieve the previous requirements. These commands are execured during the build process of the Docker image. Processing the logs is a task you do not want to do in the build step, but rather when you run the container. Therefore, use the `CMD` command to run the previously copied `process-logs.sh` script when the container is started. As we copied the script to `/usr/local/bin/`, it is available in the `PATH` and can be run without specifying the full path with just the name of the script.

When you have created the `Dockerfile`, you can build the Docker image by running the following command in the terminal on your host system (not inside any container):

```bash
# build the Docker image using the Dockerfile in the current directory
docker build --tag syslogs-image .

# run the image and use `--rm` to remove the container after it exits
docker run --rm syslogs-image
```

Now, when you run your image, it will automatically download the log file, filter the CRITICAL messages, and sort them. The output will be printed to the terminal and the container will exit after the script has finished. If you want to access the terminal of the container, you can run the image with the `-it` options and specify to run the `bash` shell instead of the script that was specified in the `CMD` instruction of the Dockerfile:

```bash
docker run --rm -it syslogs-image bash
```

Add and commit your changes to the `Dockerfile` to your repository. You could also push the image to a Docker registry, such as [Docker Hub](https://hub.docker.com/) or [GitHub Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry), if you want to share it with others or use it in other projects.


## Submitting your solution

By now, you hopefully have made individual commits and run the automated tests after each step. If not, make sure that you have saved the correct outputs of the commands in the corresponding text files in your repository. The changes should also be committed and pushed to your remote repository.


## Optional: remove the container(s) and image(s)

If you wish, you can remove the containers and images created during this exercise. Use the commands `docker container ls --all` and `docker image ls` to list all containers and images. You will need to stop and remove containers before you can remove the images. To remove a container, use the `docker container rm` command, and to remove an image, use the `docker image rm` command.

* [`docker container` documentation](https://docs.docker.com/reference/cli/docker/container/)
* [`docker image` documentation](https://docs.docker.com/reference/cli/docker/image/)


## About the exercise

This exercise has been created by Teemu Havulinna and is licensed under the [Creative Commons BY-NC-SA license](https://creativecommons.org/licenses/by-nc-sa/4.0/).

AI tools such as ChatGPT and GitHub Copilot have been used in the implementation of the task description, source code, data files and tests.
