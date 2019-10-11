# README

Simple web application displaying the like counter on Rapsberry Pi display.

## Installation Guide

### Step 1

Update your Raspbian distribution:

    sudo apt update

Git is already installed on your Raspberry. Let's check it out:

    git --version

Example output:

    => git version 2.23.0

### Step 2

Let's clone this repo:

    git clone git@github.com:arharovets/like-counter-pi.git

### Step 3

Let's install Ruby:

    cd like-counter-pi
    chmod +x install_ruby.sh
    ./install_ruby.sh

It might take some time (~2 hr on Pi Zero). Pour yourself a big cup of tea ☕️.

The output should look like:

    => Reload the current shell to get access to rbenv using:
    => source ~/.bashrc

Close current Terminal window and open a new one. Type the following command:

    source ~/.bashrc

Yay! Check the installed version:

    ruby -v
    => ruby 2.6.3somenumbersandletters

Output:

    => ruby 2.6.3somenumbersandletters

### Step 4

Time to install Ruby on Rails:

    gem install bundler
    gem install rails -v 5.2.3
    # Output:
    # =>...
    # => Successfully installed rails-5.2.0
    # => 38 gems installed
    
    rbenv rehash
    rails -v
    # Output:
    # => Rails 5.2.3

Output:

    =>...
    => Successfully installed rails-5.2.0
    => 38 gems installed
    
    rbenv rehash
    rails -v
    # Output:
    # => Rails 5.2.3

Check Rails version:

    rbenv rehash
    rails -v

Output:

    => Rails 5.2.3

### Step 5

Now that we have RoR installed...

    cd like-counter-pi
    bundle install
    rails s

Open the browser window and type `localhost:3000`. If everything is okay, Press `CTRL+C` to stop the server.

Great! Now we need to get rid of the screensaver:

    sudo apt-get install xscreensaver

... and then disable the screensaver from Pi's GUI.

### Step 6

Make sure you set the auto-login feature.
Go to `Preferences -> Raspberry Pi Configuration`, click "System" tab and set "Boot": `To Desktop`, then check "Auto Login": `Login as user 'username'`.

### Step 7

Now we need to tell our system to run Rails server on boot, and we're going to do it with `systemd`.

    RAILS_ENV=production bundle exec rake assets:precompile
    # wait a bit till precompile is finished
    sudo cp like-counter-pi.service /usr/lib/systemd/system
    systemctl enable like-counter-pi.service
    systemctl start like-counter-pi.service

### Step 8

We need to tell Raspberry what to run on the boot:

    sudo nano /etc/xdg/lxsession/LXDE-pi/autostart

Add the following line:

    /usr/bin/chromium --kiosk --disable-restore-session-state http://localhost:3000

### Step 9

We need to refresh the page every 1 minute. Do it via Cron task:

    sudo apt install xdotool
    crontab -e
    # add the following line:
    * * * * * DISPLAY=:0 xdotool key "shift+F5"

Add the following line:

    * * * * * DISPLAY=:0 xdotool key "SHIFT+F5"

Let's check if everything works:

    sudo reboot
