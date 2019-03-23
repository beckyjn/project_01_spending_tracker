require('sinatra')
require('sinatra/contrib/all')

require_relative('../models/account.rb')
require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
also_reload('../models/*')

get '/spending-tracker/transactions/' do #index
  @transactions = Transaction.all
  erb(:"transactions/index")
end

get '/spending-tracker/transactions/new' do #new
  @tags = Tag.all
  @merchants = Merchant.all
  @accounts = Account.all
  erb(:"transactions/new")
end

get '/spending-tracker/transactions/:id' do #show
  @transaction = Transaction.find(params[:id])
  erb(:"transaction/show")
end
