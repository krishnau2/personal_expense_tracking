class TransactionCreator
	EXPENSE = 'Expense'
	INCOME = 'Income'
	TRANSFER = 'Transfer'

	def initialize(form_data)
		@form_data = form_data
		@form_transaction_data = @form_data["transactions"]
		@source_account = Account.find(@form_data["source_account_id"])
		@transaction_date = @form_data["transaction_date"]
		@transaction_type = @form_data["transaction_type"]
		@destination_account = nil
	end

	def create

		AccountTransaction.transaction do 
			@form_transaction_data.each do |form_transaction|
				@destination_account = Account.find(form_transaction["destination_account_id"])
				if @transaction_type == EXPENSE
					perform_expense_transactions(form_transaction)
				elsif @transaction_type == INCOME
					perform_income_transactions
				elsif @transaction_type == TRANSFER
					perform_transfer_transactions
				end
			end
		end
	end

	def perform_expense_transactions(transaction_info)
		
		AccountTransaction.credit_transaction({
			transaction_id: "temp_123",
			account: @source_account,
			transaction_date: @transaction_date,
			comments: transaction_info["comments"],
			amount: transaction_info["amount"]
		})

		AccountTransaction.debit_transaction({
			transaction_id: "temp_123",
			account: @destination_account,
			transaction_date: @transaction_date,
			comments: transaction_info["comments"],
			amount: transaction_info["amount"]
		})
	end

	def perform_income_transactions
		
	end

	def perform_transfer_transactions
		
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