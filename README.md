# README

## Build with
- Ruby on Rails
## Get Started
### Requirements
- Ruby 2.7.1
- Rails 6.0.6.1
- Gems used
  - devise
  - dotenv-rails
  - rspec-rails
  - factory_bot_rails
  - webmock

### Clone
```bash
git clone git@github.com:deepaksharma33/event_trigger_and_email_notification.git
cd event_trigger_and_email_notification
```
### Install gems

```bash
bundle install
```
### Start Server
To start rails server
```bash
bundle exec rails server

```

### URL (local)
```bash
http://localhost:3000/
```

### Run RSpecs
```bash
bundle exec rspec
```

### Note:
untill the API-Key is recieved we can add a `.env` file in the root of the application and paste the following snippet
```
ITERABLE_API_KEY=test123
```
