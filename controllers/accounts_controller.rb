require('sinatra')
require('sinatra/contrib/all') if development?
require_relative('../models/account.rb')


get '/spending-tracker/account/:id' do #show
  @account = Account.find(params[:id])
  erb(:index)
end

get '/spending-tracker/account/:id/edit' do #edit
  @account = Account.find(params[:id])
  erb(:"accounts/edit")
end

post '/spending-tracker/account/:id' do #update
  Account.new( params ).update
  redirect to("/spending-tracker/account/1")
end
