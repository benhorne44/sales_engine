require 'csv'


class TransactionRepository

  def load_file(filename='')
    if filename == ''
      filename = './data/transactions_test.csv'
    end
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
    return @contents
  end

  def transactions
    @transactions ||= load_transactions
  end

  def load_transactions
    load_file.collect { |row| Transaction.new(row) }
  end

  def random
    transactions.sample
  end

  def find_by_transaction_id(id)
    transactions.find{|t| t.id == id }
  end

  def find_by_invoice_id(id)
    transactions.find{|t| t.invoice_id == id }
  end

  def find_all_by_invoice_id(id)
    transactions.find_all{|t| t.invoice_id == id }
  end

  def find_by_credit_card_number(number)
    transactions.find{|t| t.credit_card_number == number }
  end

  def find_all_by_credit_card_number(number)
    transactions.find_all{|t| t.credit_card_number == number }
  end

  def find_by_credit_card_expiration_date(date)
    [] << find_by("credit_card_expiration_date", date).first
  end

  def find_all_by_credit_card_expiration_date(date)
    find_by("credit_card_expiration_date", date)
  end

  def find_by_transaction_result(result)
    transactions.find{|t| t.result == result }
  end

  def find_all_by_transaction_result(result)
    transactions.find_all{|t| t.result == result }
  end

  def find_by_transaction_created_at(date)
    transactions.find{|t| t.created_at == date }
  end

  def find_all_by_transaction_created_at(date)
    transactions.find_all{|t| t.created_at == date }
  end

  def find_by_transaction_updated_at(date)
    transactions.find{|t| t.updated_at == date }
  end

  def find_all_by_transaction_updated_at(date)
    transactions.find_all{|t| t.updated_at == date }
  end

  def all
    transactions
  end
end
