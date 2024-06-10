# Intro
So you want to explore the world of AI-Voicecloning but words like "docker" and others sound like alien planets to you?  
Well - Got you covered. :) I will give you a basic tutorial on how to use RVC-WebUI with runpod.io. All you need are these things:  
- A credit card (or someone that allows you to use his/hers)
- A bit of time
- A bit of persistence and the will to follow a guide...

If you don't want/can't spend money, or if you've got a machine with a descent Nvidia-GPU (trust me... Even a GTX 1070 is enough for interfering...) - well... 
There are two options for you:
1. Check out the repos on the main-page. RVC_Boss and fumiama both have install-packages on how to use them on a Windows-machine.
2. (Best option:) Learn about docker and ssh. Especially docker is a great thing to learn, since there is so much software out there that can be run with docker
and your OS (Windows, Mac, Linux) does not matter anymore. I can recommend [this video](https://www.youtube.com/watch?v=94VQvRpjfO8) for a headstart on docker. SSH will be explained down the line in this tutorial.

## Let's go!
I will provide you with a step-by-step tutorial on how to set everything up:
1. Go to runpod.io and set up an account. Please use this link, cause it has my referal-code in it: [runpod.io](https://runpod.io?ref=896u3v9p)
2. Add a creditcard or crypto-wallet to runpod. I would recommend loading up max. $10 at the beginning, since you won't need more for your start!
3. On the left - click on "Explore" and search for `RVC-WebUI`. There should be three templates coming up with `cherrymint/rvc_webui` in them. Those are your options:
   - RVC-WebUI - RVC_BOSS - This is the "OG" in RVC. This repo is the most stable and reliable.
   - RVC-WebUI - FUMIAMA - This repo is a fork of RVC_BOSS. This repo will be more quick and open to new features in the future.
   - RVC-WebUI - MANGIO - This repo is only for archive purposes! Mangio used to be a pretty good algorithm for training, that is why I keep it up. **I STRONGLY RECOMMEND AGAINST USING IT, UNLESS YOU KNOW WHAT YOU ARE DOING!**
4. Click on the template of your choise and select "Deploy".
5. Here it becomes a bit tricky, since you have to select the GPU for what you need.
   - **I just want to change my voice...:** Cool - Switch on top the `Community Cloud`, pick anything cheap that has at least 8 GB VRAM, set a podname, leave it at 1 GPU, leave it "On-Demand" and click on "Deploy On-Demand". Just wait till all is done and proceed with the tutorial.
   - **I want to train my own models!:** Are you sure? Well... Okay... Before you do anything, research about how training actually works! Great resources can be found on AI Hub and on this Github-Repo's main-page. Pick an RTX A4000 or RTX A4500. Try to get 3 GPUs. In RVC_WebUI set the number of CPU-Processes to 24 and the Batchsize to 12. Rest is the same. (This info is based on my own experience! If you find a better combination that can beat 40 min. trainingdata in 7 seconds, let me know!)
6. Let the pod build up, click on `Connect` and start using the pod. You will have 3 Ports you can use:  
   - 7865: RVC-WebUI (the WebUI itself)
   - 7875: Tensorboard (only relevant for training)
   - 7895: Filebrowser (to upload your models)

## Warnings
Before I tell you how you can change your voice - let me be clear on some things:
1. runpod.io is a paid service and you pay for your pod **while it runs AND even when you shut it down!** To stop any payments, make sure that you **always** stop AND delete your pod after usage!
2. This repo and its' templates do NOT use volumes! So *ALL* data will be lost when you shut down your pod! Keep that in mind!

## Now I wanna change my voice...
Okay - Interfering is pretty straight forward and self-explaining, once you have the WebUI open (Port 7865). The jucy part is how to use that sweet models you downloaded from discord or whereever...  
1. Open the Connection with the Port 7895 (Filebrowser)
2. Navigate to .assets/weights
3. Upload your models
4. Inside the RVC-WebUI hit "Refresh models"
5. Done :)

Hope this was helpfull to you. :)
