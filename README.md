# IsbnValidation

Custom ActiveRecord Validation for International Standard Book Number (ISBN)
fields. Supports both ISBN-10 and ISBN-13. Will guarantee that validated fields
contain valid ISBNs.

Default behaviour is to allow either ISBN-10 or ISBN-13, but this can be
altered by specifying the :with option as shown in the example below.

For more information on ISBN, see http://en.wikipedia.org/wiki/Isbn

## Installation

To use it, add it to your Gemfile:

    gem 'isbn_validation'

The current version of isbn_validation only supports Rails 3. For Rails 2.x
support, please use v0.1.2.

## Example

    class Book < ActiveRecord::Base
      validates_isbn :isbn
      validates_isbn :isbn10, :with => isbn10
      validates_isbn :isbn13, :with => isbn13
    end

------

## Contributors

* Nick Plante
* Omer Jakobinsky - Rails 3.0 compatibility

Copyright &copy; 2011 Nick Plante, released under the MIT license
