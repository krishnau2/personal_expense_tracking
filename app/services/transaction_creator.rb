class TransactionCreator
	EXPENSE = 'Expense'
	INCOME = 'Income'
	TRANSFER = 'Transfer'

	def initialize(transaction_data)
		@transaction_data = transaction_data
		@expense_transactions = @transaction_data["transactions"]
		@source_account = Account.find(@transaction_data["source_account_id"])
		@transaction_date = @transaction_data["transaction_date"]		
		@destination_account = nil
	end

	def generate_transaction_id
        DateTime.now.to_i
	end

	def create

		AccountTransaction.transaction do 
			@expense_transactions.each do |expense_entry|
				@destination_account = Account.find(expense_entry["destination_account_id"])
				create_expense_transactions(expense_entry)
			end
		end
	end

	def create_expense_transactions(expense_entry)

		transaction_id = generate_transaction_id
		
		AccountTransaction.create_credit_transaction({
			transaction_id: transaction_id,
			account: @source_account,
			transaction_date: @transaction_date,
			comments: expense_entry["comments"],
			amount: expense_entry["amount"]
		})

		AccountTransaction.create_debit_transaction({
			transaction_id: transaction_id,
			account: @destination_account,
			transaction_date: @transaction_date,
			comments: expense_entry["comments"],
			amount: expense_entry["amount"]
		})
	end

	
	# def perform_account_transaction
	# 	Transaction.transaction do 
	# 		@form_transaction_data.each do |form_transaction| 
	# 			@destination_account = Account.find(form_transaction["destination_account_id"])
	# 			if form_transaction["action_type"] == "spending"
	# 				perform_account_spending_transaction(form_transaction["amount"])
	# 			elsif form_transaction["action_type"] == "recieving"
	# 				perform_account_recieving_transaction(form_transaction["amount"])
	# 			elsif form_transaction["action_type"] == "transfer"
	# 				perform_account_transfer_transaction(form_transaction["amount"])
	# 			end
	# 		end
	# 	end
	# end

	# def perform_account_spending_transaction(amount)
	# 	@source_account.credit(amount)
	# 	@destination_account.debit(amount)
	# end

	# def perform_account_recieving_transaction(amount)
	# 	@destination_account.credit(amount)
	# 	@source_account.debit(amount)
	# end

	# def perform_account_transfer_transaction(amount)
	# 	@source_account.credit(amount)
	# 	@destination_account.debit(amount)
	# end


	
end