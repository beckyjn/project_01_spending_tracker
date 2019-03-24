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
  redirect to('/spending-tracker/tags')
end
