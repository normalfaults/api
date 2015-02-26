## How to install on Windows

This guide will walk you through how to install and run Jellyfish-Core on Windows.

####Install Ruby, Rails, Bundler, and DevKit

Note: Use the 32-bit installer.
Use the appropriate installer for the version of Ruby that Jellyfish needs at http://railsinstaller.org/en

####Update your Rubygems install

Note: You may run into SSL errors on this step.
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

####Install pg gem

Note: pg 1.17 might be broken on Windows
````
gem install pg --pre
```
ADD SOMETHING LIKE:
if RUBY_PLATFORM=~ /win32/
    gem 'pg', '~> 0.18.0'
    gem 'tzinfo-data'

####Check out the latest code

````
git clone https://github.com/booz-allen-hamilton/jellyfish-core.git
````

####Install any dependencies

````
bundle install
````

####Install PostgreSQL

Navigate to http://www.postgresql.org/download/windows/ and select the desired installer (32-bit Windows, PostgreSQL
version supported by Jellyfish).
Follow installation steps, listen on localhost:5432, and remember your root login credentials.

####Configure PostgreSQL for Jellyfish on Windows

Add 'C:\Program Files\PostgreSQL\9.0\bin' to your Path.
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
