class CreateAccountTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :account_transactions do |t|
      t.string :transaction_id
      t.integer :account_id
      t.decimal :amount, :precision => 10, :scale => 2 
      t.datetime :transaction_date
      t.text :description
      t.text :comments

      t.timestamps
    end
  end
end
