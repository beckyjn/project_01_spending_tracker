require('sinatra')
require('sinatra/contrib/all')
#
# require_relative('../models/account.rb')
# require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
# require_relative('../models/transaction.rb')
also_reload('../models/*')

get '/spending-tracker/tags' do #index
  @tags = Tag.all
  erb(:"tags/index")
end

get '/spending-tracker/tags/new' do #new
  erb(:"tags/new")
end

post '/spending-tracker/tags' do #create
  @tag = Tag.new(params)
  @tag.save
  erb(:"tags/create")
end

get '/spending-tracker/tags/:id' do #show
  @tag = Tag.find(params[:id])
  erb(:"tags/show")
end

get '/spending-tracker/tags/:id/edit' do #edit
  @tag = Tag.find(params[:id])
  erb(:"tags/edit")
end

post '/spending-tracker/tags/:id' do #update
  Tag.new( params ).update
  redirect to("/spending-tracker/tags")
end

post '/spending-tracker/tags/:id/delete' do #destroy
  tag = Tag.find(params[:id])
  tag.delete
  redirect to("/spending-tracker/tags")
end
