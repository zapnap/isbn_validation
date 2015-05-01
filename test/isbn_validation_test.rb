require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/models'

class IsbnValidationTest < ActiveSupport::TestCase
  test "isbn10 should match regex" do
    isbn = '1590599934'
    assert isbn.match(ValidationExtensions::IsbnValidation::ISBN10_REGEX)
  end

  test "isbn10 should not match regex" do
    isbn = 'abc123ab3344'
    assert !isbn.match(ValidationExtensions::IsbnValidation::ISBN10_REGEX)
  end

  test "isbn10 with dashes and spaces should match regex" do
    isbn = '159-059 9934'
    assert isbn.match(ValidationExtensions::IsbnValidation::ISBN10_REGEX)
  end

  test "isbn13 should match regex" do
    isbn = '9781590599938'
    assert isbn.match(ValidationExtensions::IsbnValidation::ISBN13_REGEX)
  end

  test "isbn13 should not match regex" do
    isbn = '9991a9010599938'
    assert !isbn.match(ValidationExtensions::IsbnValidation::ISBN13_REGEX)
  end

  test "isbn13 with dashes and spaces should match regex" do
    isbn = '978-159059 9938'
    assert isbn.match(ValidationExtensions::IsbnValidation::ISBN13_REGEX)
  end

  test "isbn13 should start with 978 or 979" do
    book = Book.new
    book.isbn = '0123456789012'
    assert !book.valid?
    book.isbn = '9781590599938'
    assert book.valid?
    book.isbn = '979-10-90636-07-1'
    assert book.valid?
  end

  test "isbn should match either isbn10 or isbn13" do
    book = Book.new
    book.isbn = 'invalid'
    assert !book.valid?
    book.isbn = '1590599934'
    assert book.valid?
    book.isbn = '9781590599938'
    assert book.valid?
  end

  test "isbn10 should pass check digit verification" do
    book = Book10.new
    book.isbn = '159059993-4'
    assert book.valid?
  end

  test "isbn10 should fail check digit verification" do
    book = Book10.new
    book.isbn = '159059993-0'
    assert !book.valid?
  end

  test "isbn10 should handle x character checksum" do
    book = Book10.new
    book.isbn = '0-9722051-1-X'
    assert book.valid?
  end

  test "isbn10 x should be case insensitive" do
    book = Book10.new
    book.isbn = '0-9722051-1-x'
    assert book.valid?
  end

  test "isbn13 should pass check digit verification" do
    book = Book13.new
    book.isbn = '978-1590599938'
    assert book.valid?
  end

  test "isbn13 should fail check digit verification" do
    book = Book13.new
    book.isbn = '978-1590599934'
    assert !book.valid?
  end

  test "isbn13 with zero check digit should validate" do
    book = Book13.new
    book.isbn = '978-1-60746-006-0'
    assert book.valid?
  end

  test "isbn should be valid to isbn10 by default" do
    book = Book.new
    book.isbn = '1590599934'
    assert book.valid?
  end

  test "has custom error message" do
    book = Book.new
    book.isbn = '978-159059AAAAAA'
    book.valid?
    assert_equal 'is too fantastical!', book.errors[:isbn].first
  end

  test "blank should not be valid by default" do
    book = Book13.new
    book.isbn = ''
    book.valid?
    assert_equal 'is not a valid ISBN code', book.errors[:isbn].first
  end

  test "should have an option to allow nil" do
    book = Book13.new
    book.isbn = nil
    assert book.valid?
  end

  test "should have an option to allow blank" do
    book = Book10.new
    book.isbn = ''
    assert book.valid?
  end

  test "should support old syntax" do
    book = OldBook.new
    book.isbn = ''
    assert !book.valid?
    book.isbn = '1590599934'
    assert book.valid?
  end
end
