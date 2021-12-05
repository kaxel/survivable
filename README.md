# README

* Ruby version
Currently ruby '2.7.5'

* System dependencies
Just Postgres, Rails 6.1.4, and webpacker / Turbolinks (check Gemfile for more)

* Configuration
Right now the main branch pushes straight to production at https://survivable.app/
Of course this will change in the future but for now we went with the quick and dirty approach.

* Database creation
bundle exec rake db:create

* Database initialization
bundle exec rake db:migrate

* How to run the test suite
Work in progress

* Services (job queues, cache servers, search engines, etc.)
no extra services at the moment.

* Run this in DEV

  Clone the project. 
  Set your local postgres database details in config/database.yml
  run the create and migrate commands (see above)
  start server with **bundle exec rails s**
  add user account via /users/sign_up
  add your email to app/models/user.rb admin? method
  log in
  visit /my_admin
  Press every link under the load column from top to bottom
  visit http://localhost:3000/current_games/new
  load default survivors if necessary
  make selections and press BEGIN
  Don't die!

