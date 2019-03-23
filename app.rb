require('sinatra')
require('sinatra/contrib/all')

require_relative('./controllers/transactions_controller')

get '/spending-tracker/' do
  erb(:index)
end
