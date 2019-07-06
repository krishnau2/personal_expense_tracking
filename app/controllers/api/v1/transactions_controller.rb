class API::V1::TransactionsController < ApplicationController	
	protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }
	
	def index
		render json: {text: "hi", msg: "welcome to Api V1 controller"}
	end

	def create
		puts "*"*25
		puts params.inspect
		TransactionCreator.new(params).create
	end

end