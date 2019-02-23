#!/bin/bash

sudo touch /etc/systemd/system/edo-api.service
sudo chmod 664 /etc/systemd/system/edo-api.service

sudo vi /etc/systemd/system/edo-api.service

sudo systemctl daemon-reload
sudo systemctl start edo-api.service