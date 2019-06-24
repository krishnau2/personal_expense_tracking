class SummaryController < ApplicationController
  def index
    # select account_id, accounts.name, sum(amount) 
    # from transactions 
    # LEFT JOIN accounts on accounts.id = transactions.account_id  
    # group by account_id;
    # 
    @expense_summary =  Transaction
                        .joins(:account)
                        .select("transactions.account_id, accounts.name as account_name, sum(amount) as amount")
                        .group('account_id')
    
    respond_to do |format|
      format.html {render :index}
      format.json {render json: @expense_summary}
    end
  end
end
