module Zerosum
  module ValidationExtensions
    module IsbnValidation
      ISBN10_REGEX = /^(?:\d[\ |-]?){9}[\d|X]$/
      ISBN13_REGEX = /^(?:\d[\ |-]?){13}$/

      # Validates whether the value of the specified attribute is a proper ISBN number.
      # Defaults to verifying that the value is either a valid ISBN-10 or ISBN-13 number
      # but this behavior can be modified using configuration options (as shown below).
      #
      #   class Book < ActiveRecord::Base
      #     validates_isbn :isbn
      #     #validates_isbn :isbn10, :with => :isbn10
      #     #validates_isbn :isbn13, :with => :isbn13
      #   end
      #
      # Configuration options:
      # * <tt>:message</tt> - A custom error message (default is: "is not a valid ISBN")
      # * <tt>:with</tt> - A symbol referencing the type of ISBN to validate (:isbn10 or :isbn13)
      # * <tt>:allow_nil</tt> - If set to true, skips this validation if the attribute is +nil+ (default is +false+).
      # * <tt>:allow_blank</tt> - If set to true, skips this validation if the attribute is blank (default is +false+).
      # * <tt>:on</tt> - Specifies when this validation is active (default is <tt>:save</tt>, other options <tt>:create</tt>, <tt>:update</tt>).
      # * <tt>:if</tt> - Specifies a method, proc or string to call to determine if the validation should
      #   occur (e.g. <tt>:if => :allow_validation</tt>, or <tt>:if => Proc.new { |user| user.signup_step > 2 }</tt>).  The
      #   method, proc or string should return or evaluate to a true or false value.
      # * <tt>:unless</tt> - Specifies a method, proc or string to call to determine if the validation should
      #   not occur (e.g. <tt>:unless => :skip_validation</tt>, or <tt>:unless => Proc.new { |user| user.signup_step <= 2 }</tt>).  The
      #   method, proc or string should return or evaluate to a true or false value.
      def validates_isbn(*attr_names)
        configuration = { 
          :message => "is not a valid ISBN code"
        }

        configuration.update(attr_names.extract_options!)
        validates_each(attr_names, configuration) do |record, attr_name, value|
          valid = case configuration[:with]
          when :isbn10
            validate_with_isbn10(value)
          when :isbn13
            validate_with_isbn13(value)
          else
            validate_with_isbn10(value) || validate_with_isbn13(value)
          end
          record.errors.add(attr_name, configuration[:message]) unless valid
        end
      end

      def validate_with_isbn10(isbn) #:nodoc:
        if (isbn || '').match(ISBN10_REGEX)
          isbn_values = isbn.upcase.gsub(/\ |-/, '').split('')
          check_digit = isbn_values.pop # last digit is check digit
          check_digit = (check_digit == 'X') ? 10 : check_digit.to_i

          sum = 0
          isbn_values.each_with_index do |value, index|
            sum += (index + 1) * value.to_i
          end

          (sum % 11) == check_digit
        else
          false
        end
      end

      def validate_with_isbn13(isbn) #:nodoc:
        if (isbn || '').match(ISBN13_REGEX)
          isbn_values = isbn.upcase.gsub(/\ |-/, '').split('')
          check_digit = isbn_values.pop.to_i # last digit is check digit

          sum = 0
          isbn_values.each_with_index do |value, index|
            multiplier = (index % 2 == 0) ? 1 : 3
            sum += multiplier * value.to_i
          end

          result = (10 - (sum % 10))
          result = 0 if result == 10

          result == check_digit
        else
          false
        end
      end
    end
  end
end

