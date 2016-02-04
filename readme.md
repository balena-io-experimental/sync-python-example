### A Python resin sync example:

This example will allow you to develop quickly on a resin.io device by avoiding
the build/download process and directly syncing a folder to a "test" device in
the fleet.

In order to get this new super power you will need to set up a few things on your
development computer.

##### Install the Plugin
resin-sync depends on the following:
* node.js > 4.0
* resin-cli > 2.6.0

To setup resin-sync first clone the resin-sync repo to your local machine:
`git clone https://github.com/resin-io/resin-plugin-sync.git`

Now change into the resin-plugin-sync directory and use npm install to it globally:
```
cd resin-plugin-sync
sudo npm install -g
```

To check that the plugin is properly installed login with the resin-cli:
```
shaun@shaun-desktop:~$ resin login
______          _         _
| ___ \        (_)       (_)
| |_/ /___  ___ _ _ __    _  ___
|    // _ \/ __| | '_ \  | |/ _ \
| |\ \  __/\__ \ | | | |_| | (_) |
\_| \_\___||___/_|_| |_(_)_|\___/

Logging in to resin.io
? How would you like to login? (Use arrow keys)
❯ Web authorization (recommended)
  Credentials
  Authentication token
  I don't have a Resin account!
```

Now run `resin help --verbose` to see if the plugin is enabled:
```
shaun@shaun-desktop:~$ resin help --verbose
Usage: resin [COMMAND] [OPTIONS]

Run the following command to get a device started with Resin.io

  $ resin quickstart

If you need help, or just want to say hi, don't hesitate in reaching out at:

  GitHub: https://github.com/resin-io/resin-cli/issues/new
  Gitter: https://gitter.im/resin-io/chat

Primary commands:

    help [command...]                   show help                          
    quickstart [name]                   getting started with resin.io      
    login                               login to resin.io                  
    app create <name>                   create an application              
    apps                                list all applications              
    app <name>                          list a single application          
    devices                             list all devices                   
    device <uuid>                       list a single device               
    logs <uuid>                         show device logs                   

Installed plugins:

    sync <uuid>                         sync your changes with a device    

Additional commands:
```

##### Setting up the Development Device

Now that you have the resin-cli and resin-sync plugin installed, you need to setup the device-side. This is pretty straight forward and only requires these 2 steps:
1. Enable the deviceURL for the device which you want to use as your development device. This can be done from the `Actions` tab on the device page. If you need help with this, have a look at our [docs on DeviceURLs](http://docs.resin.io/#/pages/management/devices.md#enable-public-device-url).
2. Push this repo (sync-python-example) to your resin.io application.

Once the device has pulled the first update and is in the Idle state, you will be ready to start using resin-sync to really speed up your resin.io development.

##### Using resin-sync

Now that your device is setup, make some small changes to the python code in `app/` folder and run `resin sync <UUID>` from within the `sync-python-example` directory. Replace `<UUID>` with the 7 digit alphanumeric id shown on the device dashboard. Here is an example:
```
shaun@shaun-desktop:~/Desktop/sync-python-example$ resin sync 510b43d
Connecting with: 510b43d
I will run before syncing to the device...
sending incremental file list
main.py
             36 100%    0.00kB/s    0:00:00 (xfr#1, to-chk=0/2)
Synced, restarting device
```
Your new python code should now be running on the device. **Note** if you need to install dependencies with something like `pip install` or `apt-get install`, then you will still need to go through the build pipeline and do a regular `git push resin master`
