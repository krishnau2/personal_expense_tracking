class TransactionCreator
	def initialize(form_data)
		@form_data = form_data
		@form_transaction_data = @form_data["transactions"]
		@source_account = Account.find(@form_data["source_account_id"])
		@destination_account = nil
	end

	def perform_account_transaction
		Transaction.transaction do 
			@form_transaction_data.each do |form_transaction| 
				@destination_account = Account.find(form_transaction["destination_account_id"])
				if form_transaction["action_type"] == "spending"
					perform_account_spending_transaction(form_transaction["amount"])
				elsif form_transaction["action_type"] == "recieving"
					perform_account_recieving_transaction(form_transaction["amount"])
				elsif form_transaction["action_type"] == "transfer"
					perform_account_transfer_transaction(form_transaction["amount"])
				end
			end
		end
	end

	def perform_account_spending_transaction(amount)
		@source_account.credit(amount)
		@destination_account.debit(amount)
	end

	def perform_account_recieving_transaction(amount)
		@destination_account.credit(amount)
		@source_account.debit(amount)
	end

	def perform_account_transfer_transaction(amount)
		@source_account.credit(amount)
		@destination_account.debit(amount)
	end

	def create
		perform_account_transaction
	end
	
	
end