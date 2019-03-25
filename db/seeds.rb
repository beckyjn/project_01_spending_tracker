require('pry')
require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/account.rb')
require_relative('../models/transaction.rb')

account1 = Account.new({"budget" => 150})
account1.save

merchant1 = Merchant.new({"name" => "Tesco"})
merchant1.save
merchant2 = Merchant.new({"name" => "H & M"})
merchant2.save

tag1 = Tag.new({"name" => "groceries"})
tag1.save
tag2 = Tag.new({"name" => "clothes"})
tag2.save


transaction1 = Transaction.new({
  "tag_id" => tag1.id, "merchant_id" => merchant1.id,
  "account_id" => account1.id, "spend" => 30, "date" => Date.new(2019,03,15)})
transaction1.save

transaction2 = Transaction.new({
  "tag_id" => tag2.id, "merchant_id" => merchant2.id,
  "account_id" => account1.id, "spend" => 10, "date" => Date.new(2019,03,20)})
transaction2.save


transaction3 = Transaction.new({
  "tag_id" => tag1.id, "merchant_id" => merchant1.id,
  "account_id" => account1.id, "spend" => 2, "date" => Date.new(2019,03,20)})
transaction3.save







binding.pry
nil
