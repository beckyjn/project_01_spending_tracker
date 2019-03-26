require_relative('../db/sql_runner.rb')

class Account

  attr_reader :id
  attr_accessor :budget

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @budget = options['budget'].to_f
  end

  def save()
    sql = "INSERT INTO accounts (budget) VALUES ($1) RETURNING id"
    values = [@budget]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    @id = id.to_i
  end

  def self.find(id)
    sql = "SELECT * FROM accounts WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    account_data = result.first
    account = Account.new(account_data)
    return account
  end

  def update()
    sql = "UPDATE accounts SET budget = $1 WHERE id = $2"
    values = [@budget, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM accounts
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM accounts"
    account_data = SqlRunner.run(sql)
    return Account.map_items(account_data)
  end

  def remaining
    sql = "SELECT SUM(transactions.spend) AS total_spend FROM transactions
    WHERE transactions.account_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    spent = result.first['total_spend'].to_f
    return remaining = @budget - spent
  end

  def total_spend
    sql = "SELECT SUM(transactions.spend) AS total_spend FROM transactions
    WHERE transactions.account_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return spent = result.first['total_spend'].to_f
  end

  def self.map_items(account_data)
    return account_data.map { |account| Account.new(account) }
  end

  def self.delete_all
  sql = "DELETE FROM accounts"
  SqlRunner.run(sql)
  end

  def budget_warnings
    case
    when self.remaining <= 0
      return "You've spent all your budget!"
    when self.remaining <= (@budget * 0.10)
      return "Watch out! You have nearly spent all your budget."
    when self.remaining <= (@budget * 0.25)
      return "Uh oh! Your funds are getting low."
    end
  end

end
