ActiveRecord::Schema.define(:version => 1) do
  create_table :books, :force => true do |t|
    t.string :isbn
  end
end
