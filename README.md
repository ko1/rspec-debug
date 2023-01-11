# Rspec::Debug

Launch [debugger](https://github.com/ruby/debug) if spec is failed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-debug'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rspec-debug

## Usage

### Setup

Add a line `require 'rspec/debug'` into your test files, if your project doesn't use `Bundler.require`.

### Running tests

Add `RSPEC_DEBUG=1` environment variable for `rspec` (or `rake spec` and so on).

```
# example
$ RSPEC_DEBUG=1 rspec foo_spec.rb
$ RSPEC_DEBUG=1 rake spec
```

and invokes debugger if the spec is failed.

If you clone this repository, you can try this gem with the following steps:

```
$ bundle install
$ RSPEC_DEBUG=true bundle exec rake
RSpec::Debug
  has a version number

try debug, 1st
Failure:

expected false
     got true
[9, 18] in .../rspec-debug/spec/rspec_debug_spec.rb
     9|   require_relative '../lib/rspec/debug'
    10|
    11|   RSpec.describe 'try debug, 1st' do
    12|     it 'should fail and debugger' do
    13|       a = true
=>  14|       expect(a).to be false
    15|     end
    16|
    17|     it 'should fail and debugger, 2nd' do
    18|       a = 42
=>#0    block in <top (required)> (2 levels) at .../rspec-debug/spec/rspec_debug_spec.rb:14```
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
