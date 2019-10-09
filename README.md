# README

Simple web application displaying the like counter on Rapsberry Pi display.

## Installation

First of all, update your Raspbian distribution:

```bash
sudo apt update
```

Git is already installed on your Raspberry. Let's check it out:

```bash
git --version
# Example output:
# => git version 2.23.0
```

Step two. Let's clone this repo:

```bash
git clone git@github.com:arharovets/like-counter-pi.git
```

Step three. Let's install Ruby:

```bash
cd like-counter-pi
chmod +x install_ruby.sh
./install_ruby.sh
# It might take some time (~20 minutes). Pour yourself a big cup of tea.
# Output should be:
# => Reload the current shell to get access to rbenv using:
# => source ~/.bashrc
```

Close current terminal window and open another one. Type the following command:

```bash
source ~/.bashrc
```

Yay! Check the installed version:

```bash
ruby -v
=> ruby 2.6.3somenumbersandletters
```

Step four. It is time to install Ruby on Rails.

```bash
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
```

Now when we have RoR installed...Step five.

```bash
cd like-counter-pi
bundle install
rails s
# Open the browser window and type localhost:3000.
# If everything is okay, Press CTRL-C to stop the server.
```

Great! Now we need to get rid of the screensaver:

```bash
sudo apt-get install xscreensaver
```

... and then disable the screensaver from Pi's GUI.

Step six. Make sure you set the autologin feature.
Go to Preferences > Raspberry Pi Configuration, click System tab and set Boot: To Desktop, then check Auto Login: Login as user 'username'.

Step seven. Now we need to tell our system to run rails server on boot, and we're going to do it with systemd.

```bash
RAILS_ENV=production bundle exec rake assets:precompile
sudo cp like-counter-pi.service /usr/lib/systemd/system
systemctl enable like-counter-pi.service
systemctl start like-counter-pi.service
```

Step eight. We need to tell Raspberry what to run on the boot:

```bash
sudo nano /etc/xdg/lxsession/LXDE-pi/autostart

# Add the following line:
/usr/bin/chromium --kiosk --ignore-certificate-errors --disable-restore-session-state "http://localhost:3000"
```

Step nine. We need to refresh the page every 1 minute.

```bash
sudo apt install xdotool
crontab -e
# add the following line:
* * * * * DISPLAY=:0 xdotool key "shift+F5"
```

Let's check if everything works:
```bash
sudo reboot
```
