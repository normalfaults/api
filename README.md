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

####Step 3: Run brew doctor to make sure all is good

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

####Step 7: Install rbenv-default-gems plugin to install bundler automatically for us whenever we install a new version of Ruby.

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

####Step 10: Install posgreSQL (via command line, so you get the libs to install the pg gem)

````
brew install postgresql
````

####Step 11: Get postgres.app
Download at: http://postgresapp.com


####Step 12:  Check out the latest code

````
git clone https://github.com/booz-allen-hamilton/jellyfish-core.git

####Step 13:  Install any dependancies

````
bundle install
````

####Step 14:  Add this data to ./config/application.yml

````
AWS_HOST:     "localhost"
AWS_USERNAME: "user_name"
AWS_PASSWORD: "password"
AWS_DATABASE: "jellyfish"
AWS_PORT:     "5432"
CORS_ALLOW_ORIGIN: [fqdn for ux]
````

####Step 15:  Populate the database (run the following commands)

````
rake db:schema:load
rake
rake sample:jenkins
````

####Step 16.  Start the server

````
rails s
````


Copyright 2014 Booz Allen Hamilton
