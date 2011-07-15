class Book < ActiveRecord::Base
  validates_isbn :isbn, :message => 'is too fantastical!'
end

class Book10 < ActiveRecord::Base
  set_table_name 'books'
  validates_isbn :isbn, :with => :isbn10, :allow_nil => true
end

class Book13 < ActiveRecord::Base
  set_table_name 'books'
  validates_isbn :isbn, :with => :isbn13, :allow_nil => false
end
