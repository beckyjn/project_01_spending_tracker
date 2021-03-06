require_relative('../db/sql_runner.rb')
require_relative('./transaction.rb')

class Tag

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO tags (name) VALUES ($1) RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    @id = id.to_i
  end

  def self.find(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    tag_data = result.first
    tag = Tag.new(tag_data)
    return tag
  end

  def update()
    sql = "UPDATE tags SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tags
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all_by_date()
    sql = "SELECT tags.* FROM tags
    INNER JOIN transactions
    ON transactions.tag_id = tags.id
    ORDER BY transactions.date DESC"
    tag_data = SqlRunner.run(sql)
    return Tag.map_items(tag_data)
  end

  def self.all()
    sql = "SELECT * FROM tags ORDER BY name ASC"
    tag_data = SqlRunner.run(sql)
    return Tag.map_items(tag_data)
  end

  def self.map_items(tag_data)
    return tag_data.map { |tag| Tag.new(tag) }
  end

  def self.delete_all
  sql = "DELETE FROM tags"
  SqlRunner.run(sql)
  end

  def decide_filter(month, year)
    if month == "" || month == nil
      return total_spend()
    else
      return total_spend_mon(month.to_i, year.to_i)
    end
  end

  def total_spend()
    sql = "SELECT SUM(transactions.spend) FROM transactions
    WHERE tag_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.first['sum'].to_f
  end

  def total_spend_mon(month, year)
    sql = "SELECT SUM(spend) AS total_spend FROM transactions
    WHERE tag_id = $1 AND
    EXTRACT(month FROM date) = $2 AND EXTRACT(year FROM date) = $3"
    values = [@id, month, year]
    result = SqlRunner.run(sql, values)
    return spent = result.first['total_spend'].to_f
  end

  def all_transactions()
    sql = "SELECT transactions.* from transactions
    INNER JOIN tags
    ON transactions.tag_id = tags.id
    WHERE transactions.tag_id = $1
    ORDER BY date DESC"
    values = [@id]
    transaction_data = SqlRunner.run(sql, values)
    transaction = Transaction.map_items(transaction_data)
  end

  def top_merchant
    sql = "SELECT merchant_id FROM tags
    INNER JOIN transactions ON transactions.tag_id = tags.id
    WHERE transactions.tag_id = $1
    ORDER BY COUNT(transactions.merchant_id) DESC LIMIT 1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.first['merchant_id']
  end

end
