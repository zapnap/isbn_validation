require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/models'

class IsbnValidationTest < Test::Unit::TestCase
  def test_isbn10_should_match_regex
    isbn = '1590599934'
    assert isbn.match(ValidationExtensions::IsbnValidation::ISBN10_REGEX)
  end

  def test_isbn10_should_not_match_regex
    isbn = 'abc123ab3344'
    assert !isbn.match(ValidationExtensions::IsbnValidation::ISBN10_REGEX)
  end

  def test_isbn10_with_dashes_and_spaces_should_match_regex
    isbn = '159-059 9934'
    assert isbn.match(ValidationExtensions::IsbnValidation::ISBN10_REGEX)
  end

  def test_isbn13_should_match_regex
    isbn = '9781590599938'
    assert isbn.match(ValidationExtensions::IsbnValidation::ISBN13_REGEX)
  end

  def test_isbn13_should_not_match_regex
    isbn = '9991a9010599938'
    assert !isbn.match(ValidationExtensions::IsbnValidation::ISBN13_REGEX)
  end

  def test_isbn13_with_dashes_and_spaces_should_match_regex
    isbn = '978-159059 9938'
    assert isbn.match(ValidationExtensions::IsbnValidation::ISBN13_REGEX)
  end

  def test_isbn_should_match_either_isbn10_or_isbn13
    book = Book.new
    book.isbn = 'invalid'
    assert !book.valid?
    book.isbn = '1590599934'
    assert book.valid?
    book.isbn = '9781590599938'
    assert book.valid?
  end

  def test_isbn10_should_pass_check_digit_verification
    book = Book10.new
    book.isbn = '159059993-4'
    assert book.valid?
  end

  def test_isbn10_should_fail_check_digit_verification
    book = Book10.new
    book.isbn = '159059993-0'
    assert !book.valid?
  end

  def test_isbn10_should_handle_x_character_checksum
    book = Book10.new
    book.isbn = '0-9722051-1-X'
    assert book.valid?
  end

  def test_isbn13_should_pass_check_digit_verification
    book = Book13.new
    book.isbn = '978-1590599938'
    assert book.valid?
  end

  def test_isbn13_should_fail_check_digit_verification
    book = Book13.new
    book.isbn = '978-1590599934'
    assert !book.valid?
  end

  def test_isbn13_with_zero_check_digit_should_validate
    book = Book13.new
    book.isbn = '978-1-60746-006-0'
    assert book.valid?
  end

  def test_isbn_should_be_valid_to_isbn10_by_default
    book = Book.new
    book.isbn = '1590599934'
    assert book.valid?
  end

  def test_should_have_custom_error_message
    book = Book.new
    book.isbn = '978-159059AAAAAA'
    book.valid?
    assert_equal 'is too fantastical!', book.errors[:isbn].first
  end

  def test_blank_should_not_be_valid_by_default
    book = Book13.new
    book.isbn = ''
    book.valid?
    assert_equal 'is not a valid ISBN code', book.errors[:isbn].first
  end

  def test_should_have_an_option_to_allow_nil
    book = Book13.new
    book.isbn = nil
    assert book.valid?
  end

  def test_should_have_an_option_to_allow_blank
    book = Book10.new
    book.isbn = ''
    assert book.valid?
  end

  def test_should_support_old_syntax
    book = OldBook.new
    book.isbn = ''
    assert !book.valid?
    book.isbn = '1590599934'
    assert book.valid?
  end
end
