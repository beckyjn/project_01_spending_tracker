require('sinatra')
require('sinatra/contrib/all')
require('pry')
#
require_relative('../models/account.rb')
require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
also_reload('../models/*')

get '/spending-tracker/transactions' do #index
  @transactions = Transaction.all
  @accounts = Account.all.first
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

get '/spending-tracker/transactions/find' do #index
  @tags = Tag.all
  @merchants = Merchant.all
  @transactions =  Transaction.decide_which_filter(params[:tag_id], params[:merchant_id] )
  @selected_tag_id = params[:tag_id]
  @selected_merchant_id = params[:merchant_id]
  @accounts = Account.all.first
  erb(:"transactions/index")
end

# get '/spending-tracker/transactions/:id' do #show
#   @transaction = Transaction.find(params[:id])
#   erb(:"transactions/show")
# end

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
