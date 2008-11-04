require 'isbn_validation'
ActiveRecord::Base.send(:extend, Zerosum::ValidationExtensions::IsbnValidation)
