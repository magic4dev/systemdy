# Systemd

<div align="center">

![GitHub repo size](https://img.shields.io/github/repo-size/magic4dev/systemdy?label=size&style=flat-square)
[![GitHub issues](https://img.shields.io/github/issues/magic4dev/systemdy?style=flat-square)](https://github.com/magic4dev/systemdy/issues)
[![GitHub forks](https://img.shields.io/github/forks/magic4dev/systemdy?style=flat-square)](https://github.com/magic4dev/systemdy/network)
[![GitHub license](https://img.shields.io/github/license/magic4dev/systemdy?style=flat-square)](https://github.com/magic4dev/systemdy/blob/master/LICENSE.txt)
[![GitHub stars](https://img.shields.io/github/stars/magic4dev/systemdy?style=flat-square)](https://github.com/magic4dev/systemdy/stargazers)

</div>

A lightweight gem for interact with systemd.

If your goal is to develop software to quickly manage systemd services or journalctl logs, this gem is for you! :grin:


## Features

- Lightweight
- Expressive classes and methods
- Manage systemd's services lifecycle with minimal effort!
- Extract and manipulate Journalctl logs with a single action!

## Table of contents
* [Installation](#installation)
* [Dependencies](#dependencies)
* [Usage](#usage)
* [Manage services](#manage-services)
  * [Create a Systemdy Service object for control a service](#create-a-systemdy-service-object-for-control-a-service)
  * [Check if the provided service exist](#check-if-the-provided-service-exist)
  * [Check if the provided service is enabled](#check-if-the-provided-service-is-enabled)
  * [Check if the provided service is active](#check-if-the-provided-service-is-active)
  * [Check the current status of the provided service](#check-the-current-status-of-the-provided-service)
  * [Display all the properties for the provided service](#check-the-current-status-of-the-provided-service)
  * [Start the service](#start-the-service)
  * [Restart the service](#restart-the-service)
  * [Stop the service](#stop-the-service)
  * [Enable the service](#enable-the-service)
  * [Disable the service](#disable-the-service)
  * [Reload the service](#reload-the-service)
  * [Mask the service](#mask-the-service)
  * [Unmask the service](#unmask-the-service)
  * [Bonus tip: execute systemctl commands without prompt the password](#bonus-tip-execute-systemctl-commands-without-prompt-the-password)
* [Manage Journalctl logs](#manage-journalctl-logs)
  * [Display kernel logs](#display-kernel-logs)
  * [Display boot logs](#display-boot-logs)
  * [Display unit logs](#display-unit-logs)
  * [Display group_id logs (GUID)](#display-group_id-logs-guid)
  * [Display user_id logs (UID)](#display-user_id-logs-uid)
* [Contributing](#contributing)
  * [Develop a new feature](#develop-a-new-feature) 
  * [Fix a bug](#fix-a-bug) 
* [Note for testing](#note-for-testing) 
* [License](#license)
* [Useful links and resources](#useful-links-and-resources)
* [Acknowledgements](#acknowledgements) 
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'systemdy'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install systemdy
## Dependencies

The only dependecy you need is [systemd](http://www.freedesktop.org/wiki/Software/systemdy/) installed on your system (specifically libsystemd or the older libsystemdy-journal) in order to use the gem. Currently the gem support systemd 249 or higher.
## Usage

After installing the gem, the first step is to require it:

```ruby
require 'systemdy'
```
## Manage services

The first goal of this gem is to manage a systemd's service with minimal effort.

This section provides an overview of the Systemdy::Service class for managing the life cycle of a systemdy's service.

### Create a Systemdy Service object for control a service

The first step is to create a new instance of the systemdy::Service class for control the desired service

```ruby
my_postgresql_service = Systemdy::Service.new('postgresql')
```

### Check if the provided service exist

Once our object has been instantiated, you can check if the service is installed on your system

```ruby
my_postgresql_service.exist?
```

For check if a service is installed on your system without create a new instance of the Systemdy::Service class

```ruby
Systemdy::Utility::Validator.check_if_a_service_exist('postgresql')
```
if the provided service is installed on your system this methods return _**true**_, otherwise return _**false**_.

### Check if the provided service is enabled

For check if a service is enabled

```ruby
my_postgresql_service.is_enabled?
```
if the provided service is enabled this method return _**true**_, otherwise return _**false**_.

### Check if the provided service is active

For check if a service is active

```ruby
my_postgresql_service.is_active?
```
if the provided service is active this method return _**true**_, otherwise return _**false**_.

### Check the current status of the provided service

For check the current status of the service 
```ruby
my_postgresql_service.status
```
Once executed, this method return an hash with all the essential service's information like this:

```ruby
 { "Id"=>"postgresql.service",              
   "Description"=>"PostgreSQL RDBMS",          
   "ExecMainPID"=>"48615",
   "LoadState"=>"loaded",
   "ActiveState"=>"active",
   "FragmentPath"=>"/lib/systemd/system/postgresql.service",
   "ActiveEnterTimestamp"=>"Thu 2022-09-29 17:13:07 CEST",
   "InactiveEnterTimestamp"=>"Thu 2022-09-29 17:12:44 CEST",
   "ActiveExitTimestamp"=>"Thu 2022-09-29 17:12:44 CEST",
   "InactiveExitTimestamp"=>"Thu 2022-09-29 17:13:07 CEST"
 } 
```
### Display all the properties for the provided service

For check all the properties of the service 
```ruby
my_postgresql_service.properties
```
Once executed, this method return an hash with all the service's properties like this:

```ruby
 { "Type"=>"oneshot",
    "Restart"=>"no",
    "NotifyAccess"=>"none",
    ....
 }
```

To extract the value of a specific property

```ruby
my_postgresql_service.properties["MemorySwapMax"]
```

### Start the service

For start the service 
```ruby
my_postgresql_service.start
```

### Restart the service

For restart the service 
```ruby
my_postgresql_service.restart
```

### Stop the service

For stop the service 
```ruby
my_postgresql_service.stop
```

### Enable the service

For enable the service 
```ruby
my_postgresql_service.enable
```

### Disable the service

For disable the service 
```ruby
my_postgresql_service.disable
```

### Reload the service

For reload the service 
```ruby
my_postgresql_service.reload
```

### Mask the service

For mask the service 
```ruby
my_postgresql_service.mask
```
### Unmask the service

For unmask the service 
```ruby
my_postgresql_service.unmask
```
## Bonus tip: execute systemctl commands without prompt the password

The methods **start**, **restart**, **stop**, **enable**, **disable**, **reload**, **mask** and **unmask** detect non-root users and automatically execute the methods with sudo.

By default, sudo needs that a non-root user(in this case you) is authenticated using a password for complete the method execution. This is a great thing, but some times you may need to execute this methods without type the password. 

In this case you need to configure sudo without a password.

The first step for achieve this is gain root access:

```console
non_root_user@my-machine:~$ sudo -i
[sudo] password for non_root_user: 
```

After provided the correct password backup your /etc/sudoers file by typing the following command:

```console
root@my-machine:~# cp /etc/sudoers /root/sudoers.bak 
```

Next step is edit the /etc/sudoers file by typing the visudo command:

```console
root@my-machine:~# visudo 
```

Append/edit the following lines in the /etc/sudoers file and substitute 'your_account_name' with your linux account name.
```console
'your_account_name' ALL=(ALL) NOPASSWD: /bin/systemctl
```

This line anable you to run ‘systemctl’ commands without a password. 

Save with CTRL + X

```console
root@my-machine:~# exit
```
Exit from root session and you are ready to go! :sunglasses:
## Manage Journalctl logs

The second goal of this gem is to provide a set of useful methods for retrieving journalctl log data.

This section provides a brief overview of the Systemdy::Journal class for managing journalctl log information.

### Display kernel logs

Sometimes we need to check if the kernel is working properly or if something went wrong to get useful information to help us fix the problem.

For getting the kernel logs 

```ruby
Systemdy::Journal.display_kernel_logs
```
This class method executed with no arguments return an array with: 
* a default size of 10 (the last 10 lines of log)
* a start period not older than '00:00 AM' o' clock (today)
* an end period not newer than the method execution timenow

Obviously this method allows you to filter the kernel logs by passing **3** positional arguments:

* **since**: a start period not older than the specified date

* **to**: an end period not older than the specified date

* **lines**: the exact number of last log lines 

For example:

If you want to analyze the last 50 log lines ranging from a month ago to 10:00 of the current day:

```ruby
Systemdy::Journal.display_kernel_logs(since: '1 month ago', to: '10:00', lines: 50)
```

If you want to analyze the last 20 log lines ranging from a week ago to yesterday:

```ruby
Systemdy::Journal.display_kernel_logs(since: '1 week ago', to: 'yesterday', lines: 20)
```

You can also filter the logs by specific dates in the format YYYY-MM-DD for example:

```ruby
Systemdy::Journal.display_kernel_logs(since: '2022-08-27', lines: 200)
```

If the passed arguments not match anything the method return an array with a message like this:

```ruby
["-- No entries --"]
```

### Display boot logs

Sometimes we need to know if our system is working properly at boot time and if something went wrong to get useful information to help us fix the problem.

For getting the boot logs 

```ruby
Systemdy::Journal.display_boot_logs
```
This class method executed with no arguments return an array with: 
* a default size of 10 (the last 10 lines of log)
* a start period not older than '00:00 AM' o' clock (today)
* an end period not newer than the method execution timenow

Obviously as for the previous method, you can filter the boot logs by passing **4** positional arguments:

* **argument**: in this case the boot's number

* **since**: a start period not older than the specified date

* **to**: an end period not older than the specified date

* **lines**: the exact number of last log lines 

For example:

If you want to analyze the last 50 log lines of the second boot ranging from a month ago to 10:00 of the current day:

```ruby
Systemdy::Journal.display_boot_logs(argument: 2, since: '1 month ago', to: '10:00', lines: 50)
```

If you want to analyze the last 20 log of the third boot lines ranging from a week ago to yesterday:

```ruby
Systemdy::Journal.display_boot_logs(argument: 3, since: '1 week ago', to: 'yesterday', lines: 20)
```

You can also filter the logs by specific dates in the format YYYY-MM-DD for example:

```ruby
Systemdy::Journal.display_boot_logs(since: '2022-08-27', lines: 200)
```
If the passed arguments not match anything the method return an array with a message like this:

```ruby
["-- No entries --"]
```

### Display unit logs

Another common task is to filter logs based on the unit that we need information on. 

To do this, we just simply need to pass the name of the unit as argument, for example we need to analyze postgresql unit logs:

```ruby
Systemdy::Journal.display_unit_logs(argument: 'postgresql')
```

In this case the class method return an array with: 
* a default size of 10 (the last 10 lines of log)
* a start period not older than '00:00 AM' o' clock (today)
* an end period not newer than the method execution timenow

Obviously this method require the unit's name as argument, if executed with no arguments return a message like this:

```ruby
"display_unit_logs require an argument!"
```

Obviously as for the previous method, you can filter the unit logs by passing **4** positional arguments:

* **argument**: in this case the unit's name

* **since**: a start period not older than the specified date

* **to**: an end period not older than the specified date

* **lines**: the exact number of last log lines 

For example:

If you want to analyze the last 50 log lines of the potsgresql service ranging from a month ago to 10:00 of the current day:

```ruby
Systemdy::Journal.display_unit_logs(argument: 'postgresql', since: '1 month ago', to: '10:00', lines: 50)
```

If you want to analyze the last 20 log lines of the potsgresql service ranging from a week ago to yesterday:

```ruby
Systemdy::Journal.display_unit_logs(argument: 'postgresql', since: '1 week ago', to: 'yesterday', lines: 20)
```

You can also filter the logs by specific dates in the format YYYY-MM-DD for example:

```ruby
Systemdy::Journal.display_unit_logs(argument: 'postgresql', since: '2022-08-27', lines: 200)
```

If the passed arguments not match anything the method return an array with a message like this:

```ruby
["-- No entries --"]
```

### Display group_id logs (GUID)

To find all messages related to a particular group, we just simply need to pass the GUID of the group as argument, for example:

```ruby
Systemdy::Journal.display_group_id_logs(argument: 1000)
```

In this case the class method return an array with: 
* a default size of 10 (the last 10 lines of log)
* a start period not older than '00:00 AM' o' clock (today)
* an end period not newer than the method execution timenow

Obviously this method require the GUID as argument, if executed with no arguments return a message like this:

```ruby
"display_group_id_logs require an argument!"
```

Obviously as for the previous method, you can filter the GUID logs by passing **4** positional arguments:

* **argument**: in this case the GUID

* **since**: a start period not older than the specified date

* **to**: an end period not older than the specified date

* **lines**: the exact number of last log lines 

For example:

If you want to analyze the last 50 log lines of the GUID 1000 ranging from a month ago to 10:00 of the current day:

```ruby
Systemdy::Journal.display_group_id_logs(argument: 1000, since: '1 month ago', to: '10:00', lines: 50)
```

If you want to analyze the last 20 log lines of the GUID 1000 ranging from a week ago to yesterday:

```ruby
Systemdy::Journal.display_group_id_logs(argument: 1000, since: '1 week ago', to: 'yesterday', lines: 20)
```

You can also filter the logs by specific dates in the format YYYY-MM-DD for example:

```ruby
Systemdy::Journal.display_group_id_logs(argument: 1000, since: '2022-08-27', lines: 200)
```

If the passed arguments not match anything the method return an array with a message like this:

```ruby
["-- No entries --"]
```

### Display user_id logs (UID)

To find all messages related to a particular user, we just simply need to pass the UID of the user as argument, for example:

```ruby
Systemdy::Journal.display_user_id_logs(argument: 1000)
```

In this case the class method return an array with: 
* a default size of 10 (the last 10 lines of log)
* a start period not older than '00:00 AM' o' clock (today)
* an end period not newer than the method execution timenow

Obviously this method require the UID as argument, if executed with no arguments return a message like this:

```ruby
"display_user_id_logs require an argument!"
```

Obviously as for the previous method, you can filter the UID logs by passing **4** positional arguments:

* **argument**: in this case the UID

* **since**: a start period not older than the specified date

* **to**: an end period not older than the specified date

* **lines**: the exact number of last log lines 

For example:

If you want to analyze the last 50 log lines of the UID 1000 ranging from a month ago to 10:00 of the current day:

```ruby
Systemdy::Journal.display_user_id_logs(argument: 1000, since: '1 month ago', to: '10:00', lines: 50)
```

If you want to analyze the last 20 log lines of the UID 1000 ranging from a week ago to yesterday:

```ruby
Systemdy::Journal.display_user_id_logs(argument: 1000, since: '1 week ago', to: 'yesterday', lines: 20)
```

You can also filter the logs by specific dates in the format YYYY-MM-DD for example:

```ruby
Systemdy::Journal.display_user_id_logs(argument: 1000, since: '2022-08-27', lines: 200)
```

If the passed arguments not match anything the method return an array with a message like this:

```ruby
["-- No entries --"]
```
## Contributing

We :heart: pull requests from everyone. 

Everyone interacting in the systemdy project's codebases is expected to follow the [code of conduct](https://github.com/magic4dev/systemdy/blob/master/CODE_OF_CONDUCT.md).

### Develop a new feature

If you wanna develop a new feature:

* Fork this project

* Clone the repo with the following command:

      git clone git@github.com:your-username/systemdy.git

* Install dependencies with:

      bin/setup

* Make your changes
* Write tests. 

    **NOTE**: For a correct testing procedure read our [Note for testing](#note-for-testing)
* Make the tests pass with the following command:

      rake spec

* Add notes about your changes to the `CHANGELOG.md` file

* Write a good commit message
* Push to your fork
* [Submit a pull request](https://github.com/magic4dev/systemdy/compare)
* Wait for us, we will reply as soon as possible
* We may suggest changes for better code quality
* Please, if you push more than mone commit let's keep the history clean :stuck_out_tongue_winking_eye:

Thank you for your contribution! :handshake:

### Fix a bug

If you wanna fix a bug:

* Fork this project

* Clone the repo with the following command:

      git clone git@github.com:your-username/systemdy.git

* Install dependencies with:

      bin/setup

* Make your changes
* Write tests. 

    **NOTE**: For a correct testing procedure read our [Note for testing](#note-for-testing)
* Make the tests pass with the following command:

      rake spec

* Add notes about your changes to the `CHANGELOG.md` file

* Write a good commit message
* Push to your fork
* [Submit a pull request](https://github.com/magic4dev/systemdy/compare)
* Wait for us, we will reply as soon as possible
* We may suggest changes for better code quality
* Please, if you push more than mone commit let's keep the history clean :stuck_out_tongue_winking_eye:

Thank you for your contribution! :handshake:

## Note for testing

This gem was tested on a __postgresql__ service. 
    
For better testing install __postgresql__ service on your system.
    
If you don't want to install it:
    
* go to _spec/setup/test_variables.rb_ 

and replace: 

* let (:real_service_name) { 'postgresql' }

with:

* let (:real_service_name) { 'a_installed_service_on_your_system' }

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Useful links and resources

 - An interesting article on [how to run sudo commands without password](https://www.linuxshelltips.com/run-sudo-commands-without-password/)
 - The official systemdy documentation for [time specification](https://www.freedesktop.org/software/systemd/man/systemd.time.html)
 
## Acknowledgements

 - Thanks to [@colstrom](https://github.com/colstrom) and his [systemized](https://github.com/colstrom/systemized) for the great inspiration 