require('sinatra')
require('sinatra/contrib/all') if development?
#
require_relative('../models/account.rb')
require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')

get '/spending-tracker/transactions' do #index
  @transactions = Transaction.all
  @account = Account.all.first
  @tags = Tag.all
  @merchants = Merchant.all
  erb(:"transactions/index")
end

get '/spending-tracker/transactions/new' do #new
  @tags = Tag.all
  @merchants = Merchant.all
  @accounts = Account.all
  erb(:"transactions/new")
end

post '/spending-tracker/transactions' do #create
  transaction = Transaction.new(params)
  transaction.save
  redirect to("/spending-tracker/transactions")
end

get '/spending-tracker/transactions/find' do #filter
  @tags = Tag.all
  @merchants = Merchant.all
  @selected_tag_id = params[:tag_id].to_i
  @selected_merchant_id = params[:merchant_id].to_i
  @transactions =  Transaction.decide_which_filter(params[:tag_id], params[:merchant_id], params[:start_date], params[:end_date] )
  @account = Account.all.first
  erb(:"transactions/index")
end



get '/spending-tracker/transactions/:id/edit' do #edit
  @transaction = Transaction.find(params[:id])
  @tags = Tag.all
  @merchants = Merchant.all
  @accounts = Account.all
  erb(:"transactions/edit")
end

post '/spending-tracker/transactions/:id' do #update
  Transaction.new( params ).update
  redirect to("/spending-tracker/transactions")
end

post '/spending-tracker/transactions/:id/delete' do #destroy
  transaction = Transaction.find(params[:id])
  transaction.delete
  redirect to("/spending-tracker/transactions")
end
