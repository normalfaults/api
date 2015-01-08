jellyfish-core
=======

Jellyfish-Core is the API layer of Jellyfish.  It provides access for the UX
and for mobile applications.  It's really cool.

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

####Step 15:  Populate the database

Run the following rake commands.  You only need to run "rake sample:jenkins" if
you are wanting, sample data (useful for development).  Please note that this
rake task does not create the database or the database user (those will need
to be created based on the DB you are using)

````
rake db:schema:load
rake
rake sample:jenkins
````

####Step 16.  Start the server (development)

````
rails s
````


Copyright 2014 Booz Allen Hamilton
