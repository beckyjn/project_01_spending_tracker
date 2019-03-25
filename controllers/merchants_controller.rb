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
  redirect to('/spending-tracker/merchants')
end

get '/spending-tracker/merchants/:id' do #show
  @merchant = Merchant.find(params[:id])
  erb(:"merchants/show")
end

get '/spending-tracker/merchants/:id/edit' do #edit
  @merchant = Merchant.find(params[:id])
  erb(:"merchants/edit")
end

post '/spending-tracker/merchants/:id' do #update
  Merchant.new( params ).update
  redirect to("/spending-tracker/merchants")
end

post '/spending-tracker/merchants/:id/delete' do #destroy
  merchant = Merchant.find(params[:id])
  merchant.delete
  redirect to("/spending-tracker/merchants")
end
