require 'isbn_validation'

ActiveRecord::Base.class_eval do
  extend Zerosum::ValidationExtensions::IsbnValidation
end
