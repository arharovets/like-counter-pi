![http://www.wtfpl.net](http://www.wtfpl.net/wp-content/uploads/2012/12/wtfpl-badge-1.png)

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
    chmod +x install_ruby.sh # makes the script executable
    ./install_ruby.sh

It might take some time (~2 hr on Pi Zero). Pour yourself a big cup of tea ☕️.

The output should look like:

    => Reload the current shell to get access to rbenv using:
    => source ~/.bashrc

Close current Terminal window and open a new one. Type the following command:

    source ~/.bashrc

Yay! Check the installed version:

    ruby -v

Output:

    => ruby 2.6.3somenumbersandletters

### Step 4

Now that we have Ruby installed...

    cd like-counter-pi
    bundle install

### Step 5

Make sure your Raspberry boots into console mode, and run:

`thor like_counter:live`
