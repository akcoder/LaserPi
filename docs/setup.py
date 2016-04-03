#!/usr/bin/env python3

import os
import sys
from subprocess import Popen
from shutil import copyfile

base_dir = '/'
current_dir = os.path.dirname(os.path.realpath(__file__))

def inplace_change(filename, old_string, new_string):
    s = open(filename).read()
    if old_string in s:
        print('Changing "{old_string}" to "{new_string}"'.format(**locals()))
        s = s.replace(old_string, new_string)
        with open(filename, 'w') as f:
            f.write(s)
    else:
        print('No occurrences of "{old_string}" found.'.format(**locals()))

def setup_splash():
    to_add = 'quiet logo.nologo vt.global_cursor_default=0'
    path = os.path.join(base_dir, 'boot', 'cmdline.txt')
    if not to_add in open(path).read():
        print('Appending "{0}" to "{1}"'.format(to_add, path))
        with open(path, "a") as myfile:
            myfile.write(' {0}'.format(to_add))

    splash_image = os.path.join(current_dir, 'splash.png')

    print("Setting X background image")
    new_env = dict(os.environ)
    new_env['DISPLAY'] = ':0'
    print('\nPlease manually execute\npcmanfm --display=:0 --set-wallpaper={0}\n'.format(splash_image))
    #Popen('pcmanfm --display=:0 --set-wallpaper={0}'.format(splash_image).split(),  env=new_env, shell=True)

    path = os.path.join(base_dir, 'etc', 'init.d', 'asplashscreen')

    if not os.path.exists(path):
        print("Adding the splash screen file to init.d")
        copyfile(os.path.join(current_dir, 'asplashscreen'), path)
        print("Updating the path to the splash screen png")
        inplace_change(path, '/home/pi/splash.png', splash_image)

        print("Making asplashscreen executable")
        Popen('chmod a+x {0}'.format(path).split())
        Popen('insserv {0}'.format(path).split())


def disable_screen_blanking():
    #Disable screen blanking
    path = os.path.join(base_dir, 'etc', 'lightdm', 'lightdm.conf')
    inplace_change(path, '#xserver-command=X', 'xserver-command=X -s 0 -dpms')

def enable_one_wire():
    to_add = 'dtoverlay=w1-gpio,gpiopin=26'
    path = os.path.join(base_dir, 'boot', 'config.txt')
    if not to_add in open(path).read():
        print('Appending "{0}" to "{1}"'.format(to_add, path))
        with open(path, "a") as myfile:
            myfile.write('\n{0}\n'.format(to_add))

    #1-Wire
    #sudo echo "dtoverlay=w1-gpio" >> /boot/config.txt


def main():
    #Setup splash screen
    setup_splash()
    disable_screen_blanking()
    enable_one_wire()
    pass

if __name__ == "__main__":
    if not 'SUDO_UID' in os.environ.keys():
      print("this program requires super user privileges")
      sys.exit(1)
    main()
