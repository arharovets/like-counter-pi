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

Step seven. We need to tell Raspberry what to run on the boot:

```bash
cd like-counter-pi
chmod +x ./execute_counter.sh
cd
sudo nano /etc/xdg/lxsession/LXDE-pi/autostart

# Add the following lines:
@bash -lc /home/pi/execute_counter.sh
@lxterminal -e "/home/pi/open_browser.sh"
```

Let's check if everything works:
```bash
sudo reboot
```
