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
