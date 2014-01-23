class Book < ActiveRecord::Base
  validates :isbn, :isbn_format => { :message => 'is too fantastical!' }
end

class Book10 < ActiveRecord::Base
  self.table_name = 'books'
  validates :isbn, :isbn_format => { :with => :isbn10, :allow_blank => true }
end

class Book13 < ActiveRecord::Base
  self.table_name = 'books'
  validates :isbn, :isbn_format => { :with => :isbn13, :allow_nil => true }
end

class OldBook < ActiveRecord::Base
  self.table_name = 'books'
  validates_isbn :isbn
end
