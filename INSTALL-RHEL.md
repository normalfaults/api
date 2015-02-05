## How to install on Mac OS X Mavericks

This guide will walk you through how to install and run Jellyfish-Core on RedHat Enterprise Linux (or similar,
like CentOS).

####Create jellyfish user

````
sudo useradd jellyfish
````

####Change to the jellyfish user

````
su - jellyfish
````

####Install Pre-Requisites

````
sudo yum install git
sudo yum install gcc-c++ patch readline readline-devel zlib zlib-devel
sudo yum install libyaml-devel libffi-devel openssl-devel make
sudo yum install bzip2 autoconf automake libtool bison iconv-devel
sudo yum install sqlite-devel
````

####Install PostgreSQL

Please install PostgreSQL 9.3+ via their docs


####Install rbenv / rbenv-build / rbenv-sudo

Install rbenv as per the rbenv / rbenv-build / rbenv-sudo installation guide.


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


####Install pg gem

````
gem install pg
```


####Check out the latest code

````
git clone https://github.com/booz-allen-hamilton/jellyfish-core.git
````


####Install any dependencies

````
bundle install
````


####Add this data to ./config/application.yml

You will need to create this file yourself (it is already in the .gitignore),
the Figaro gem uses this to to "create" ENVIRONMENT variables.  Alternatively,
you can simply create ENVIRONMENT vars yourself.

Note: You will need to install PostgreSQL per their directions

````
DATABASE_URL:     "postgres://jellyfish_user:jellyfish_pass@localhost:5432/jellyfish"
CORS_ALLOW_ORIGIN: "localhost:5000"
DEFAULT_URL: "http://jellyfish-core-url.server.com"
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


####Start the server (for development)

````
rails s
````


#####Install Nginx

Get the Package for your RHEL Version (http://nginx.org/en/linux_packages.htm), and install

````
sudo rpm -i rpm -i <url to repo file from above page>
sudo yum install nginx
````

Delete the default site config
````
sudo rm /etc/nginx/conf.d/default.conf
````

Create jellyfish.conf (with the file contents below)
````
sudo vi /etc/nginx/conf.d/jellyfish.conf

# File (update the my_app_url.com) and

upstream myapp_puma {
  server unix:///tmp/myapp_puma.sock;
}

server {
  listen  80;
  root /home/jellyfish/jellyfish-core/public;

  location / {
        #all requests are sent to the UNIX socket
        proxy_pass http://myapp_puma;
        proxy_redirect     off;

        proxy_set_header   Host             $host:$proxy_port;
        proxy_set_header   X-Real-IP        $remote_addr;
        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;

        client_max_body_size       10m;
        client_body_buffer_size    128k;

        proxy_connect_timeout      90;
        proxy_send_timeout         90;
        proxy_read_timeout         90;

        proxy_buffer_size          4k;
        proxy_buffers              4 32k;
        proxy_busy_buffers_size    64k;
        proxy_temp_file_write_size 64k;
  }
}
````

Restart Nginx
````
sudo /etc/init.d/nginx restart
````

Start Core
````
cd /home/jellyfish/jellyfish-core
bundle exec puma -e production -d -b unix:///tmp/myapp_puma.sock
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
