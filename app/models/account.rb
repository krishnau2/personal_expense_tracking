class Account < ApplicationRecord
    has_many :transactions, dependent: :destroy

    def credit(amount)
    	self.transactions.create(amount: -(amount))
    end

    def debit(amount)
    	self.transactions.create(amount: amount)
    end
end
