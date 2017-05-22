# Maybe So

Ever get annoyed that ActiveRecord blows up if you set a boolean column to nil? Have you ever wanted to allow custom "truthy" values for booleans rather than just `true`, `false`, `0`, and `1`? Wish you could call `to_bool` on random objects and have it return something reasonable?

Maybe So handles this for you!

Tested on Ruby 2.x (MRI)

[![Build Status](https://secure.travis-ci.org/ministrycentered/maybe_so.svg?branch=master)](http://travis-ci.org/ministrycentered/maybe_so)

## Installation

Add this line to your application's Gemfile:

    gem 'maybe_so'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install maybe_so

## Usage

### ActiveRecord

Let's say you have an ActiveRecord attribute called `hidden` that you want to only be 0 or 1, never nil.

```ruby
add_column :products, :hidden, :boolean, default: false, null: false
```

Add the `boolean_attribute` class method on your class.

```ruby
class Product < ActiveRecord::Base
  boolean_attribute :hidden
end
```

By default, Maybe So accepts the following case insensitive values as `true`. Everything else is `false`. You can override these values with the `truthy_values` option (see below).

```ruby
true, "true", "Y", "Yes", 1, "1", "T"
```

### ActiveModel

```ruby
class Product
  include ActiveModel::Model

  boolean_attribute :hidden
end
```

### Configuration options

`boolean_attributes` accepts an options hash for the following:

- `truthy_values`: array of values (will be coerced into strings when checking) to be considered truthy
- `skip_validator`: this will _omit_ adding the `validates_inclusion_of` to ensure records are not valid unless they are set to `true` or `false`. Note it does _not_ validate presence. If you want that, you'll need to add a separate validation.

Example custom configuration:

```ruby
class Product < ActiveRecord::Base
  boolean_attribute :hidden, truthy_values: ["Si"], skip_validator: true
end
```

### #to_bool

`String`, `Integer`, `TrueClass`, `FalseClass`, `NilClass` all have `#to_bool` added.

```ruby
"Yes".to_bool # Uses the same truthy values as shown above
# => true

"zing".to_bool
# => false

"1".to_bool
# => true

1.to_bool
# => true

42.to_bool
# => false

true.to_bool
# => true

false.to_bool
# => false

nil.to_bool
# => false
```

## Copyright

Copyright (c) 2017 James Miller and Tanner Mares
