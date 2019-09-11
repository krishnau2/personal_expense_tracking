class AccountTransaction < ApplicationRecord
    belongs_to :account

    def self.credit_transaction(data)
    	self.create({
    		transaction_id: data[:transaction_id],
    		account_id: data[:account].id, 
    		transaction_date: data[:transaction_date],
    		comments: data[:comments],
    		amount: -(data[:amount].to_f)
    	})
    end

    def self.debit_transaction(data)
    	self.create({
    		transaction_id: data[:transaction_id],
    		account_id: data[:account].id, 
    		transaction_date: data[:transaction_date],
    		comments: data[:comments],
    		amount: data[:amount].to_f
    	})
    end
end
