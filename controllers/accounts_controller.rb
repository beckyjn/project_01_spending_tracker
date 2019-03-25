require('sinatra')
require('sinatra/contrib/all')
#
require_relative('../models/account.rb')
# require_relative('../models/merchant.rb')
# require_relative('../models/tag.rb')
# require_relative('../models/transaction.rb')
also_reload('../models/*')

get '/spending-tracker/budget/:id' do #show
  @account = Account.find(params[:id])
  erb(:"accounts/show")
end

get '/spending-tracker/budget/:id/edit' do #edit
  @account = Account.find(params[:id])
  erb(:"accounts/edit")
end

post '/spending-tracker/budget/:id' do #update
  Account.new( params ).update
  redirect to("/spending-tracker/budget/1")
end
