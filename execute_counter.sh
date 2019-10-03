#!/bin/bash

cd like-counter-pi
rails s
chromium-browser --kiosk http://localhost:3030/
