## How to install on Mac OS X Mavericks

This guide will walk you through how to install and run Jellyfish-Core on a Mac.  Generally, this would be for
development, however you can run it in production as well.  This will setup the app to run on port 5000, if you want
it to run on a different port, you will need to use Apache or Nginx (this doc will not cover that).

####Install the Mac command line tools:

````
xcode-select --install
````

####Install Homebrew

````
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo 'export PATH=/usr/local/bin:$PATH' >> ~/.bash_profile
source ~/.bash_profile
````


####Install rbenv

````
brew install rbenv ruby-build rbenv-gem-rehash
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
````

####Install to Ruby 2.1.5, and set that as the global version

````
rbenv install 2.1.5
rbenv global 2.1.5
````

####Install bundler

````
gem install bundler
````

####Install rbenv-default-gems plugin
This will re-install gems automatically for us whenever we install a new version of Ruby.

````
brew install rbenv-default-gems
echo "bundler" >> ~/.rbenv/default-gems
````

####Skip rdoc generation (OPTIONAL)
````
echo "gem: --no-document" >> ~/.gemrc
````

####Install rails gem

````
gem install rails
echo "rails" >> ~/.rbenv/default-gems
````

####Install PostgreSQL / pg gem
This will install PostgreSQL via the command line, so we can get the libs to install the pg gem

````
brew install postgresql
gem install pg
````

####Get postgres.app
You can use the PostreSQL from step 10, but this app is easier to use
Download at: http://postgresapp.com


####Check out the latest code

````
git clone https://github.com/booz-allen-hamilton/jellyfish-core.git
````

####Install any dependencies

````
bundle install
````

####Add this data to ./.env

You will need to create this file yourself (it is already in the .gitignore),
the dotEnv gem uses this to to "create" ENVIRONMENT variables.  Alternatively,
you can simply create ENVIRONMENT vars yourself.

Note: You will need to install PostgreSQL per their directions

````
DATABASE_URL=postgres://jellyfish_user:jellyfish_pass@localhost:5432/jellyfish
CORS_ALLOW_ORIGIN=localhost:5000
DEFAULT_URL=http://jellyfish-core-url.server.com
````
####Populate the database

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

####Start the server (development mode)

````
rails s
````

####Running in production



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
