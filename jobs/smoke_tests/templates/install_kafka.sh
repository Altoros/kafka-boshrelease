#!/bin/bash

set -e

wget -c https://bootstrap.pypa.io/get-pip.py
chmod +x get-pip.py
sudo python get-pip.py
export PATH=$PATH:/usr/local/bin
sudo pip install -U pip setuptools
sudo pip install kafka
