GoCritik
========

This application is a means to create a Review Website, where users can pour in their ratings and reviews. The USP of the app is that the resource being rated is not specific, it may be a business / product / service/ person which is generated dynamically by the admin of the website.

## Pre-Requisites

- You need to have mysql running on your machine and the mysql adapter for rails. Follow the given or any other command to install them

  ```
  sudo apt-get install mysql-server mysql-client
  sudo apt-get install libmysql-ruby libmysqlclient-dev
  ```

## Installation

- Fork this repository
- Run bundle install
- Setup config/database.yml similar to config/database_example.yml
- Setup config/config.yml, similar to config/config_example.yml (used to provide resource-specific information)
- Run rake db:create ( MySql required to be installed on your system )
- Run rake db:migrate

## Optional Rake Tasks

- Run db:setup:admin to create any normal user of this website an admin
- Run db:setup:templates to generate liquid templates for styling the dynamic components in the app
- Run rake ts:index ( To index the search from the fields marked as searchable )
- Run rake ts:start ( To start the searchd daemon )

## Features

- Admin of this website can create specific fields for a resource.
- Admin can create a resource by populating data into these fields.
- Admin can edit any field or any resource at any time 
- A user can create reviews, make ratings on resource
- A review can be liked, commented upon by user
- A comment can be liked by user

## Reporting issues
- If you face any issue, report me at vidit@vinsol.com