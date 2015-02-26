## How to install on Windows

This guide will walk you through how to install and run Jellyfish-API on Windows.

####Preface
This guide only provides steps for installing with Ruby2.1.5. Jellyfish may require a higher version. There are
four primary methods of installing the Jellyfish stack on Windows. Check if any of these methods are appropriate for
you. Note: This version of the install guide uses RailsInstaller.
* RailsInstaller
* RubyInstaller
* Adapted RubyInstaller for newer version (https://github.com/oneclick/rubyinstaller)
* Compile from source

####Install Ruby, Rails, Bundler, Git and DevKit with RailsInstaller

Navigate to http://railsinstaller.org/en to select and download the latest RailsInstaller for Windows.
Run the installer. Click next. Accept all of the licenses and click next. Use the default installation path and check
the boxes for installing Git and adding Ruby, DevKit and Git to the path. Click install.
When the installation finishes, keep the box checked to have Git and SSH set up for you. Click finish to exit.

####Update your Rubygems install

Note: You may run into SSL errors on this step. If you are behind a proxy server, attempt to run this with a direct
internet connection. If this is not the case, attempt the instructions at
https://gist.github.com/luislavena/f064211759ee0f806c88. This will provide you with an updated CA cert.

````
gem update --system
````

####Verify your installations

````
ruby -v
gem -v
````

####Install bundler

````
gem install bundler
````

####Skip rdoc generation (OPTIONAL)

````
echo "gem: --no-document" >> ~/.gemrc
````

####Install rails gem

````
gem install rails
````

####Install the pg and tzinfo-data gems

Note: These gems are specific to Windows and may be the cause of unwanted behavior.
````
gem install pg --pre
gem install tzinfo-data
```

If these gems are ever to be added to the Jellyfish API Gemfile, we would add something like:

````
if RUBY_PLATFORM=~ /win32/
    gem 'pg', '~> 0.18.0'
    gem 'tzinfo-data'
````

####Check out the latest code

Change your current working directory to the parent directory of where you want Jellyfish-API installed.
Then, get the latest version of Jellyfish by cloning the repo using Git in command prompt:

````
cd C:\my_projects
git clone https://github.com/booz-allen-hamilton/jellyfish-core.git
````

####Install any dependencies

Run this command from the directory that you just cloned into:

````
bundle install
````

####Install PostgreSQL

Navigate to http://www.postgresql.org/download/windows/ and select the desired installer (32-bit Windows, PostgreSQL
version supported by Jellyfish).
Follow installation steps, listen on localhost:5432 (set by default), and remember your root login credentials (you
will be asked to type these in).

####Configure PostgreSQL for Jellyfish on Windows

Add 'C:\Program Files (x86)\PostgreSQL\9.0\bin' to your Path.

````
setx path "%PATH%;C:\Program Files (x86)\PostgreSQL\9.0\bin"
````

Either through pgAdmin or psql, create a new login role. USE THE WINDOWS ACCOUNT NAME YOU ARE LOGGED INTO (e.g. 'jdoe').
Give this role a password, the ability to create databases, and superuser.

````
psql -U root postgres
````

Then in psql terminal:

````
CREATE ROLE 'your-local-username' WITH PASSWORD 'jellyfish-pass' CREATEDB SUPERUSER
````

Exit psql then from the command line, attempt to create a db as follows:

````
createdb jellyfish
````

If this does not work, you will need to change some PostgreSQL configs (pg\_hba.conf or pg\_ident.conf).
Follow http://www.postgresql.org/docs/9.1/static/auth-pg-hba-conf.html.

####Add database data to ./.env

You will need to create this file yourself (it is already in the .gitignore),
the dotEnv gem uses this to to "create" ENVIRONMENT variables.  Alternatively,
you can simply create ENVIRONMENT vars yourself.

````
DATABASE_URL=postgres://YOUR_LOCAL_USERNAME:jellyfish_pass@localhost:5432/jellyfish
CORS_ALLOW_ORIGIN=localhost:5000
DEFAULT_URL=localhost:3000
````

####Populate the database

Run the following rake commands.  You only need to run "rake sample:demo" if
you are wanting, sample data (useful for development).  Please note that this
rake task does not create the database or the database user (those will need
to be created based on the DB you are using)

````
rake db:setup
rake db:seed
rake sample:demo
````

####Start the server (for development)

````
rails s
````

####Upkeep Rake Tasks

The following rake commands need to be executed to maintain Jellyfish Core.

````
# Updates the budgets for projects
rake upkeep:update_budgets

# Pull down AWS pricing (not used at the moment)
rake upkeep:get_aws_od_pricing

# Get the status of VM's from ManageIQ
rake upkeep:poll_miq_vms

# Run the delayed job workers (this is what processes the orders to the various systems
rake jobs:work
````


Copyright 2015 Booz Allen Hamilton
