# Shoulda Matchers for Cucumber

[![Gem Version][version-badge]][rubygems] [![Build Status][travis-badge]][travis] [![MIT License][license-badge]](LICENSE) [![Total Downloads][downloads-total]][rubygems] [![Downloads][downloads-badge]][rubygems] [![Hound][hound-badge]][hound]

The gem to be used to support the [shoulda matchers](https://github.com/thoughtbot/shoulda-matchers) and [rspec expectation](https://github.com/rspec/rspec-expectations) syntaxes in the cucumber step methods, without picking up the whole rspec, or specifying the shoulda matchers.

[version-badge]: https://img.shields.io/gem/v/shoulda-matchers-cucumber.svg
[rubygems]: https://rubygems.org/gems/shoulda-matchers-cucumber
[travis-badge]: https://img.shields.io/travis/majioa/shoulda-matchers-cucumber/master.svg
[travis]: https://travis-ci.org/majioa/shoulda-matchers-cucumber
[downloads-total]: https://img.shields.io/gem/dt/shoulda-matchers-cucumber.svg
[downloads-badge]: https://img.shields.io/gem/dtv/shoulda-matchers-cucumber.svg
[downloads-badge]: https://img.shields.io/gem/dtv/shoulda-matchers-cucumber.svg
[hound-badge]: https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg
[hound]: https://houndci.com
[license-badge]: https://img.shields.io/badge/License-MIT-0000FF.png


### RSpec-Expectations

Use this instead of the RSpec ifself in case you just use the specific module gem
'rspec-expectations' to test webpart(s).

Include `shoulda-matchers-cucumber` in your Gemfile:

``` ruby
group :test do
   gem 'shoulda-matchers-cucumber'
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shoulda-matchers-cucumber

Now you can use matchers in your tests as for Cucumber without picking-up the whole RSpec suite.

## Configuring
Then, configure the gem to integrate with RSpec specifying the test framework as `:cucumber`:

``` ruby
Shoulda::Matchers.configure do |config|
   config.integrate do |with|
      with.test_framework :cucumber
      # ...
   end
end
```

## Usage

Write your cucumer rules as usual:

```cucumber
Feature: User model

Scenario: Valid model of User
   Given default User model
   Then the model is valid
```

Then write its steps using shoulda matchers' syntax:

```ruby
Given("default User model") do
   User.create(name: "Vasja")
end

Then("the model is valid") do
   expect(User.first).to validate_presence_of(:name)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/majioa/shoulda-matchers-cucumber. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Shoulda::Matchers::Cucumber project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/majioa/shoulda-matchers-cucumber/blob/master/CODE_OF_CONDUCT.md).
