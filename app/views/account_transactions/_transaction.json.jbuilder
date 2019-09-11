json.extract! transaction, :id, :transaction_id, :account_id, :amount, :transaction_date, :description, :comments, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
