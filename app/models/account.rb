class Account < ApplicationRecord
    has_many :account_transactions, dependent: :destroy

    # def credit(amount)
    # 	self.transactions.create(amount: -(amount.to_f))
    # end

    # def debit(amount)
    # 	self.transactions.create(amount: amount.to_f)
    # end
end
