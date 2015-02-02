jellyfish-core
=======

[![Code Climate](https://codeclimate.com/repos/54c2c15e69568066da0003ed/badges/c6cc02c252d341b6eeb3/gpa.svg)](https://codeclimate.com/repos/54c2c15e69568066da0003ed/feed)
[![Test Coverage](https://codeclimate.com/repos/54c2c15e69568066da0003ed/badges/c6cc02c252d341b6eeb3/coverage.svg)](https://codeclimate.com/repos/54c2c15e69568066da0003ed/feed)
[![Build Status](https://magnum.travis-ci.com/booz-allen-hamilton/jellyfish-core.svg?token=hzrJLxrVn5bNaxiZp1bx&branch=master)](https://magnum.travis-ci.com/booz-allen-hamilton/jellyfish-core)

Jellyfish-Core is the API layer of Jellyfish.  It provides access for the UX
and for mobile applications.

## Local Setup Procedures (for Mac OS X Mavericks)

####Step 1: Install the Mac command line tools:

````
xcode-select --install
````

####Step 2: Install homebrew

````
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo 'export PATH=/usr/local/bin:$PATH' >> ~/.bash_profile
source ~/.bash_profile
````

####Step 3: Run brew doctor
This will make sure that all is good

````
brew doctor
````

####Step 4: Install rbenv

````
brew install rbenv ruby-build rbenv-gem-rehash
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
````

####Step 5: Install to Ruby 2.1.5, and set that as the global version

````
rbenv install 2.1.5
rbenv global 2.1.5
````

####Step 6: Install bundler

````
gem install bundler
````

####Step 7: Install rbenv-default-gems plugin
This will re-install gems automatically for us whenever we install a new version of Ruby.

````
brew install rbenv-default-gems
echo "bundler" >> ~/.rbenv/default-gems
````

####Step 8 (optional): Skip rdoc generation
````
echo "gem: --no-document" >> ~/.gemrc
````

####Step 9: Install rails

````
gem install rails
echo "rails" >> "~/.rbenv/default-gems"
````

####Step 10: Install posgreSQL / pg gem
This will install via command line, so you get the libs to install the pg gem

````
brew install postgresql
gem install pg
````

####Step 11: Get postgres.app (Mac only)
You can use the PostreSQL from step 10, but this app is easier to use
Download at: http://postgresapp.com


####Step 12:  Check out the latest code

````
git clone https://github.com/booz-allen-hamilton/jellyfish-core.git
````

####Step 13:  Install any dependancies

````
bundle install
````

####Step 14:  Add this data to ./config/application.yml

You will need to create this file yourself (it is already in the .gitignore),
the Figaro gem uses this to to "create" ENVIROMENT variables.  Alternatively,
you can simply create ENVIROMENT yourself.


````
AWS_HOST:     "database-host-name.server.com"
AWS_USERNAME: "database_username"
AWS_PASSWORD: "database_password"
AWS_DATABASE: "database_name"
AWS_PORT:     "5432"
CORS_ALLOW_ORIGIN: [fqdn of ux server]
````

In order to enable core to connect to a ManageIQ instance, add the
following variables to ./config/application.yml as well.

````
MANAGEIQ_HOST: "https://miq-host:miq-port"
MANAGEIQ_SSL:  "0"
MANAGEIQ_USER: "miq-user"
MANAGEIQ_PASS: "miq-pasword"
````

####Step 15:  Populate the database

Run the following rake commands.  You only need to run "rake sample:jenkins" if
you are wanting, sample data (useful for development).  Please note that this
rake task does not create the database or the database user (those will need
to be created based on the DB you are using)

````
rake db:schema:load
rake
rake db:seed
rake sample:jenkins
````

####Step 16.  Start the server (development)

````
rails s
````

####Upkeep Rake Tasks

The following rake commands can be executed to maintain Jellyfish Core.

````
rake upkeep:update_budgets
````

This command updates the spent attribute of all Projects by iterating over each
Project's OrderItems and then computing the aggregate spent by applying the
hourly, monthly and setup price for each OrderItem since their creation.

````
rake upkeep:get_aws_od_pricing
````

This command displays the on demand pricing for different EC2 instances available on AWS.
Does not pull pricing data for S3 buckets or RDS.

````
rake upkeep:poll_miq_vms
````

This command displays the status of all VMs available in ManageIQ using the ManageIQ API and
creates an alert for each change in VM status.



Copyright 2014 Booz Allen Hamilton
