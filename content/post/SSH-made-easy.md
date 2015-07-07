+++
Categories = ["Development", "Blog"]
Description = ""
Tags = ["Development", "SSH"]
date = "2015-07-07T16:58:45-04:00"
title = "SSH behine firewall made easy"
draft = false
+++

# Settings

    (Desktop)---(Intermediate Server)--- || --- (Remote Server)

# Step-by-step setup

## setup reverse tunnel

1. on CU desktop

    ```
    ssh -fN -R 7000:localhost:22 -i aws-key.pem ec2-user@52.10.241.71
    ```
    
2. To test whether reverse tunnel works, on AWS Server: 

    ```
    ssh fanz@localhost -p 7000 
    ```
    
If prompted with login. Works.

## Setup `ProxyCommand`

on Laptop, add the following to ~/.ssh/config

	Host aws-ssh
        HostName 52.10.241.71
        User ec2-user
        IdentityFile ~/Dropbox/keys/Fan.pem

    Host cs
        User fanz
        ProxyCommand ssh -W localhost:7000 aws-ssh

Then, simply try `ssh cs`. Should works!
