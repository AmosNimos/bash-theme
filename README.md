# Terminal theme.
> Export Gnome Terminal Profile
[source](https://gist.github.com/reavon/0bbe99150810baa5623e5f601aa93afc)

## Export theme
- List profiles
~~~
dconf dump /org/gnome/terminal/legacy/profiles:/
~~~

- Determine the terminal profile string for the profile you will need. This is the terminal profile that I will export:
~~~
[:1430663d-083b-4737-a7f5-8378cc8226d1]
foreground-color='#C3C3C7C7D1D1'
visible-name='Material Colors'
palette=['#070736364141', '#EBEB60606B6B', '#C3C3E8E88D8D', '#F7F7EBEB9595', '#8080CBCBC3C3', '#FFFF24249090', '#AEAEDDDDFFFF', '#FFFFFFFFFFFF', '#00002B2B3636', '#EBEB60606B6B', '#C3C3E8E88D8D', '#F7F7EBEB9595', '#7D7DC6C6BFBF', '#6C6C7171C3C3', '#343443434D4D', '#FFFFFFFFFFFF']
default-size-columns=100
default-size-rows=28
use-system-font=false
use-theme-colors=false
font='Source Code Pro 10'
allow-bold=false
bold-color-same-as-fg=true
bold-color='#FFFFFFFFFFFF'
background-color='#1E1E28282C2C'
audible-bell=false
scrollbar-policy='never'
~~~

> In this case the string that will be needed to export this profile would be __:1430663d-083b-4737-a7f5-8378cc8226d1__

- The command to export that profile is (note: don't forget the ending slash)
~~~
dconf dump /org/gnome/terminal/legacy/profiles:/:1430663d-083b-4737-a7f5-8378cc8226d1/ > theme-profile.dconf
~~~

## Import theme

- Replace the profile __:1430663d-083b-4737-a7f5-8378cc8226d1__ with theme-profile.
~~~
dconf load /org/gnome/terminal/legacy/profiles:/:1430663d-083b-4737-a7f5-8378cc8226d1/ < theme-profile.dconf
~~~

___

# Neofetch theme
https://github.com/dylanaraps/neofetch/wiki/Images-in-the-terminal

# XML file?
These are theme for the Gedit text editor.
