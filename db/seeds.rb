require('pry')
require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/account.rb')

account1 = Account.new({"budget" => 150})
account1.save

account1.budget = 200
account1.update

merchant1 = Merchant.new({"name" => "Tesco"})
merchant1.save

tag1 = Tag.new({"name" => "groceries"})
tag1.save




binding.pry
nil
