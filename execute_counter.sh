#!/bin/bash

cd ~/like-counter-pi
bundle exec rails server
chromium-browser --kiosk http://localhost:3000/
