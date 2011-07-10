# IsbnValidation

Custom ActiveRecord Validation for International Standard Book Number (ISBN) fields.
Supports both ISBN-10 and ISBN-13. Will guarantee that validated fields contain valid
ISBNs.

Default behaviour is to allow either ISBN-10 or ISBN-13, but this can be altered by specifying the :with option as shown in the example below.

For more information on ISBN, see http://en.wikipedia.org/wiki/Isbn

## Installation

### Rails 3
This fork of ISBN Validation is *not* backward compatible and would work only on Rails 3.0.

To use it, add it to your Gemfile:

    gem 'isbn_validation', :git => 'git@github.com:Omer/isbn_validation.git'

### Rails 2

Please refer to the [original repo](https://github.com/zapnap/isbn_validation)

## Example

    class Book < ActiveRecord::Base
      validates_isbn :isbn
      validates_isbn :isbn10, :with => isbn10
      validates_isbn :isbn13, :with => isbn13
    end

------

## Contributors

* Nick Plante - Original Author
* Omer Jakobinsky - Rails 3.0 compatibility

Copyright &copy; 2008 Nick Plante, released under the MIT license
