jellyfish-core
=======

Jellyfish-Core is the API layer of Jellyfish.  It provides access for the UX
and for mobile applications.  It's really cool.


Local Setup Procedures

1.  Get your enviroment setup according to this page:

https://boozallen.atlassian.net/wiki/display/DBPI/Ruby+on+Rails+development+setup+for+Mac+OSX

2.  Check out the latest code

https://github.com/booz-allen-hamilton/jellyfish-core

3.  Run

````
bundle install
````

4.  Add an application.yml file with DB info to app/config

````
AWS_HOST:     "localhost"
AWS_USERNAME: "user_name"
AWS_PASSWORD: "password"
AWS_DATABASE: "jellyfish"
AWS_PORT:     "5432"
CORS_ALLOW_ORIGIN: [fqdn for ux]
````

5.  Populate the database (run the following commands)

````
rake db:schema:load
rake
rake sample:jenkins
````
6.  Start the server

````
rails s
````


Copyright 2014 Booz Allen Hamilton
