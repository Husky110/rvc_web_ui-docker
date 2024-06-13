# RVC-WebUI-Docker
## Newbie-Tutorials
For newbies there is a tutorial available for this repo! [Check it out!](documentation/for_dummies_english.md)  
And now for the technical bits:
## Purpose
This repo serves the purpose to make the build-process public, that is beeing used to build my RVC-WebUI-Containers on runpod.
(See [DockerHub](https://hub.docker.com/r/cherrymint/rvc_webui))  
I would kindly ask you to use the exported versions on runpod.io (just use their Explore-Feature and search for RVC. The ones with cherrymint in them are mine). With this you support me. :)   
I do not add a licence to this project, since I am only taking the repos, pull them, download the models and then upload them to Dockerhub.    
So what you do with them, is up to you, but I advise on checking if your local laws on copy- and personality-rights.

## Main-Repos:
 - RVC_Boss: https://github.com/RVC-Project/Retrieval-based-Voice-Conversion-WebUI
 - fumiama: https://github.com/fumiama/Retrieval-based-Voice-Conversion-WebUI  
 - mangio: https://github.com/Mangio621/Mangio-RVC-Fork
 - Applio: https://github.com/IAHispano/Applio

Credits and Cudos go to those repos and their respective contributers.

## External Repos:
- https://github.com/filegator/filegator

Credits and Cudos go to those repos and their respective contributers.

## How to use
### General
The build-process is mainly meant to be working with [runpod.io](https://runpod.io/?ref=896u3v9p) (<--- I've put my referal-code in there, just so you know. Would be nice if you use it. :) ), but works locally aswell.  
I can test this locally only on my system, which is Ubuntu 22.04 with a GTX 1070, Driver 535.171.04 and CUDA 12.2. Not top notch-tho, so your milage may vary!  

### Runpod-Config
You should be able to use the images build by this repo without any other configurations. If you don't want to build them yourself, just use mine: [DockerHub](https://hub.docker.com/r/cherrymint/rvc_webui)  
Just make sure you have your public-key set in your runpod-profile.  
For training, I would recommend using 3x RTX A5000 or 3x RTX A4000 with 24 CPU-Processes and a Batchsize of 12. That gives you 1 epoch at about every 7 seconds, so 1000 epochs take about 2 hours, which will cost you 2-3$. Using newer or more cards did not do anything beneficial in my tests. (Written at 2024-06-10)

### What does it do?
The created docker-images setup everything you need and even add Tensorboard. How to use Tensorboard can be read here:  
- https://docs.aihub.wtf/rvc/resources/epochs--tensorboard/#usage-guide (General Usage-Guide)
- https://rentry.org/RVC_making-models (in-depth guide on training with Tensorboard - unfortunately the image-links are broken)

### Local usage
If you wanna use them locally, just open 0.0.0.0:7875 for the WebUI, 0.0.0.0:7865 for tensorboard and 0.0.0.0:8080 for filebrowser. 
Build the images by using this:
`docker build -t mydockerregistry/myusername/mycontainername:mytagname --build-arg REPO="<MYREPO>" .`  
MYREPO here supports this:
- `web_ui-rvc_boss` will build the [RVC-WebUI by rvc_boss](https://github.com/RVC-Project/Retrieval-based-Voice-Conversion-WebUI)
- `web_ui-fumiama` will build the [RVC-WebUI by fumiama](https://github.com/fumiama/Retrieval-based-Voice-Conversion-WebUI)
- `applio` will build the [Applio-Project by IAHispano](https://github.com/IAHispano/Applio)

To run the container use: `docker run -d -p 7875:7875 -p 7865:7865 -p 7895:7895 mydockerregistry/myusername/mycontainername:mytagname`

### If you wanna use ssh instead of the Filebrowser
- add `-p 22:22` to your docker run-command
- add `-e PUBLIC_KEY="<MY PUBLIC KEY>"` to your docker run-command and connect through it.

### Possible Questions
#### Why no volume?
Since I use those containers for training or one-time-interference, I don't need a volume most of the time. If you want to persist your data, just add some bind-mounts to the /app-subfolders you need. [Infos on bind-mounts](https://docs.docker.com/storage/bind-mounts/)

#### Why no docker-compose.yml?
Again - I don't need it. You can do this yourself - I believe in you. :)

#### Why is there no info on the mangio-tag in your DockerHub-Repo?
The mangio-tag was an old version I had locally lying around on my homelab. I do not update that tag. But funny enough - the base-dockerfile is the one I used for that tag. :)

# Changelog:
## 2024-06-13
- Changed Filemanager from filebrowser a PHP-Based one (python filebrowser didn't work...) (taken from https://github.com/filegator/filegator)
## 2024-06-12
- Eased up build-process (You can now build via a tag-name)
- Added image-tag for [Applio](https://github.com/IAHispano/Applio)
## 2024-06-10:
- Removed the pip-installation for tensorboard, since all Repos bring them themselves
- Removed the need for an ssh-key to make this more "dummy"-approachable
- Added a filebrowser
- Added a Tutorial for dummies
- Made Templates on runpod.io