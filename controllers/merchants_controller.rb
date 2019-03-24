require('sinatra')
require('sinatra/contrib/all')
#
# require_relative('../models/account.rb')
require_relative('../models/merchant.rb')
# require_relative('../models/tag.rb')
# require_relative('../models/transaction.rb')
also_reload('../models/*')

get '/spending-tracker/merchants' do #index
  @merchants = Merchant.all
  erb(:"merchants/index")
end

get '/spending-tracker/merchants/new' do #new
  erb(:"merchants/new")
end

post '/spending-tracker/merchants' do #create
  @merchant = Merchant.new(params)
  @merchant.save
  erb(:"merchants/created")
end

get '/spending-tracker/merchants/:id' do #show
  @merchant = Merchant.find(params[:id])
  erb(:"merchants/show")
end
