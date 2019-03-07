# MailOptOut

### Build

![CircleCI branch](https://img.shields.io/circleci/project/github/ImpactMapper/mail_opt_out/master.svg)
[![Travis CI](https://img.shields.io/travis/ImpactMapper/mail_opt_out.svg?branch=master)](https://travis-ci.org/ImpactMapper/mail_opt_out)

### Maintainability

![Maintenance](https://img.shields.io/maintenance/yes/2019.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/51aa08d8908ab501d537/maintainability)](https://codeclimate.com/github/ImpactMapper/mail_opt_out/maintainability)

### Code Quality 

[![Code Climate coverage](https://img.shields.io/codeclimate/coverage/ImpactMapper/mail_opt_out.svg)](https://codeclimate.com/github/ImpactMapper/mail_opt_out)
[![Coverage Status](https://coveralls.io/repos/github/ImpactMapper/mail_opt_out/badge.svg?branch=master)](https://coveralls.io/github/ImpactMapper/mail_opt_out?branch=master)
[![Code Climate issues](https://img.shields.io/codeclimate/issues/ImpactMapper/mail_opt_out.svg)](https://codeclimate.com/github/ImpactMapper/mail_opt_out/issues)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/ImpactMapper/mail_opt_out.svg)](https://codeclimate.com/github/ImpactMapper/mail_opt_out/progress/maintainability)
[![Code Climate maintainability (percentage)](https://img.shields.io/codeclimate/maintainability-percentage/ImpactMapper/mail_opt_out.svg)](https://codeclimate.com/github/ImpactMapper/mail_opt_out/code)
[![Code Climate technical debt](https://img.shields.io/codeclimate/tech-debt/ImpactMapper/mail_opt_out.svg)](https://codeclimate.com/github/ImpactMapper/mail_opt_out/trends/technical_debt)

### Size 

![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/ImpactMapper/mail_opt_out.svg)
![GitHub repo size in bytes](https://img.shields.io/github/repo-size/ImpactMapper/mail_opt_out.svg)

### Usage 

![Gem](https://img.shields.io/gem/dv/mail_opt_out/0.1.0.svg)
![Gem](https://img.shields.io/gem/v/mail_opt_out.svg)
  
### Activity

![GitHub All Releases](https://img.shields.io/github/downloads/ImpactMapper/mail_opt_out/total.svg)
![GitHub last commit (master)](https://img.shields.io/github/last-commit/ImpactMapper/mail_opt_out/master.svg)
![GitHub Release Date](https://img.shields.io/github/release-date/ImpactMapper/mail_opt_out.svg)

### Documentation 
  
[![Inline docs](http://inch-ci.org/github/ImpactMapper/mail_opt_out.svg?branch=master)](http://inch-ci.org/github/ImpactMapper/mail_opt_out)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](http://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/gem/v/vcr.svg?style=flat-square)](https://rubygems.org/gems/mail_opt_out)

### Security 

[![Libraries.io dependency status for latest release](https://img.shields.io/librariesio/release/ImpactMapper/mail_opt_out.svg)](https://libraries.io/github/ImpactMapper/mail_opt_out)

Simple Mail Opt In/Out Service, its based on JSONAPI Format.

## Usage

Subscribe a user to a list of diffusion 

```shell
curl -X POST \
  http(s)://<domain>/users/:user_id/subscriptions/subscribe \
  -H 'Accept: application/vnd.api+json' \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{
  "data": {
    "attributes": {
      "list": "Newsletters"
    }
  }
}'
```

Unubscribe a given user to a list of diffusion 

```shell
curl -X POST \
  http(s)://<domain>/users/:user_id/subscriptions/subscribe \
  -H 'Accept: application/vnd.api+json' \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{
  "data": {
    "attributes": {
      "list": "Whatever List"
    }
  }
}'
```

Get the subscriptions of a given user


```shell
curl -X GET \
  http(s)://<domain>/users/:user_id/subscriptions \
  -H 'Accept: application/vnd.api+json' \
  -H 'Content-Type: application/vnd.api+json' \
  -H 'cache-control: no-cache'
```

```json
{
    "data": [
        {
            "id": "1bbd2fc2-9deb-4c07-ab10-13ebea5f7ab5",
            "type": "subscription",
            "attributes": {
                "list": "Joel Test List"
            }
        }
    ]
}
```

See API Doc here https://documenter.getpostman.com/view/2646236/S11NMH9y

## Installation

```ruby
gem 'mail_opt_out'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install mail_opt_out
```

### Routes 

```shell
mount MailOptOut::Engine => '/'
```

### Migrations

`bundle exec rails generate migration CreateMailOptOutLists`

```ruby
class CreateMailOptOutLists < ActiveRecord::Migration[5.2]
  def change
    create_table :mail_opt_out_lists do |t|
      t.string :number
      t.string :name

      t.timestamps
    end
  end
end
```

```bash
bundle exec rails generate migration CreateMailOptOutSubscriptions
```

```ruby
class CreateMailOptOutSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :mail_opt_out_subscriptions do |t|
      t.references :list
      t.references :user, polymorphic: true, index: true

      t.timestamps
    end
  end
end
```

## Third services 

This Engine is designed to support serveral services, for now it come with Mailchimp

## Mailchimp

This gem come with a integration to Mailchimp, however is totally optional.

If you want to activate it 

```ruby
gem 'gibbon'
```

Set `ENV['MAILCHIMP_API_KEY']`

To synchronize your Mailchimp list add Rake Task to periodically launch `MailOptOut.sync`

## Contributing

make sure all tests still passed, and every contribution is covered by test.

`rake`

## Todo

By Priority 1 low, 5 high

Engine
- [ ] 1 Add Generators 
- [ ] 1 Rake Task to sync existing data with services 
- [ ] 1 Rake Task to setup, start and cleanup dummy app 
- [ ] 1 Extract Engine, Gem and Services 
- [ ] mail-opt-out-engine
- [ ] mail-opt-out-core
- [ ] mail-opt-out-mailchimp

Core 
- [ ] 1 Rename List#number => List#code
- [ ] 5 Make List Name Unique on Number Scope
- [ ] 3 Make configurable email method on User#email
- [ ] 3 Make configurable User#name, first_name, last_name
- [ ] 1 Add Code Doc

Services (Mailchimp)
- [ ] 5 Put Service on Job
- [ ] 2 Set FirstName LastName if it possible 

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
