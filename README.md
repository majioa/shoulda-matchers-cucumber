# Shoulda::Matchers::Cucumber

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/shoulda/matchers/cucumber`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

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
Then, configure the gem to integrate with RSpec specifying the test framework as `:rspec_exp`:

``` ruby
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :cucumber
    # ...
  end
end
```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/majioa/shoulda-matchers-cucumber. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Shoulda::Matchers::Cucumber project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/majioa/shoulda-matchers-cucumber/blob/master/CODE_OF_CONDUCT.md).
