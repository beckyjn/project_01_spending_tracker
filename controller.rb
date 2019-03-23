require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/account.rb')
require_relative('./models/merchant.rb')
require_relative('./models/tag.rb')
require_relative('./models/transaction.rb')
also_reload('./models/*')

get '/spending-tracker/' do #index
  @transactions = Transaction.all
  erb(:index)
end

get '/spending-tracker/:id' do #show
  @transaction = Transaction.find(params[:id])
  erb(:show)
end
