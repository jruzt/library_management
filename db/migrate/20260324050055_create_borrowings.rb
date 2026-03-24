class CreateBorrowings < ActiveRecord::Migration[7.2]
  def change
    create_table :borrowings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.datetime :borrowed_at, null: false
      t.date :due_on, null: false
      t.datetime :returned_at

      t.timestamps
    end

    add_index :borrowings, %i[user_id book_id], unique: true, where: "returned_at IS NULL", name: "index_active_borrowings_on_user_and_book"
    add_index :borrowings, :due_on
  end
end
