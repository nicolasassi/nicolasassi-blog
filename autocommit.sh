#!/bin/bash

# Change to the directory you want to monitor
cd ~/dev/nicolasassi

# Add all changes
git add .

# Commit changes with a timestamp
git commit -m "Auto commit on $(date)"

# Push to the remote repository
git push origin main
