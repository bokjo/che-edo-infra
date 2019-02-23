#!/bin/bash 

cd ~/gitlab

curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh | sudo bash

sudo yum install gitlab-runner

sudo gitlab-runner register

# /etc/gitlab-runner/config.toml 