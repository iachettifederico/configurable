# Configurable

Grant your objets the posibility to embed configurations to
themselves.

Easily config any Ruby object.

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'configurable', git: 'git://github.com/iachettifederico/configurable.git'
```
And then execute:

    $ bundle

Or install it yourself as:

    $ gem install specific_install
    $ gem specific_install -l git://github.com/iachettifederico/configurable.git

## Usage

Say you have an object you need to configure, maybe a Report that may
have a default font and default paper size. Just include the
Configurable module into the report class:

```ruby
class Report
  include Configurable
end
``` 
The configurable module adds the "config" method to the class. So now
you can say:

```ruby
report = Report.new
report.cofig default_font: :comic_sans
```
And access the new attribute like this:

```ruby
report.config.default_font
=> :comic_sans
```

You may also provide a configuration block. Continuing with the
previous example:

```ruby
report.cofig do |c|
  c.default_paper_size = :a4
end
```

And now you can access the new atribute the same way that the previous
one:

```ruby
report.cofig.default_paper_size
=> :a4
```

If an attribute isn't configured, it just return nil. So you can do
something like this

```ruby
puts "Default paper size: #{ report.config.default_paper_size }" if report.config.default_paper_size
```

### Precedence

Keeping up with our Report example, you can modify a previously
assigned attribute, the same way you did the first time (after all,
comic sans is not the right font for a report - or anything for that matter)

```ruby
report = Report.new
report.cofig default_font: :arial
report.config.default_font
=> :arial
```

You can also provide both a hash parameter and a block. In that case,
the precedence is taken by the block:

```ruby
report = Report.new
report.cofig(default_font: :comic_sans) do |c|
  c.default_font = :arial
end
```
And access the new attribute like this:

```ruby
report.config.default_font
=> :arial
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## TODO

1. Allow the config method to be named differently
2. Define a default return value (or action) for undefined attributes
other than nil
3. Allow the following syntax:

```ruby
report = Report.new
report.cofig
  default_font :arial
end
report.config.default_font
=> :arial
```
