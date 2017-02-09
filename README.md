# Opensaz

This is my first serious repo.!

It's a Ruby Gem.

It's used to read .saz file(generated by Fiddler, consist of HTTP requests and responses).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'opensaz'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install opensaz

## Usage

{% highlight ruby %}
require 'opensaz'

a = Opensaz.read("/Users/keegoo/workspace/entity.saz")

a.packages.each do |x|
  puts x.id
  puts x.request.headers[:path]
  puts x.request.headers[:method]
  puts x.request.headers[:content_type]
  puts x.request.body

  puts x.response.headers
  puts x.response.body
end
{% endhighlight %}

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/opensaz. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

