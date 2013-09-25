require 'csv'


class TransactionRepository

  def load_file(filename='')
    if filename == ''
      filename = '../data/transactions.csv'
    end
    @contents = CSV.read"#{filename}", headers: true, header_converters: :symbol
    return @contents
  end

  def format_transaction_data_into_hash
    headers = ['transaction_id', 'invoice_id', 'credit_card_number', 'credit_card_expiration_date', 'transaction_result', 'transaction_created_at', 'transaction_updated_at']
    @transactions = []
    @contents.each do |row|
      transaction_id = row[:id]
      credit_card_number = row[:credit_card_number]
      credit_card_expiration_date = row[:credit_card_expiration_date]
      transaction_result = row[:result]
      invoice_id = row[:invoice_id]
      transaction_created_at = row[:created_at]
      transaction_updated_at = row[:updated_at]


      transaction_data = [transaction_id, invoice_id, credit_card_number, credit_card_expiration_date, transaction_result, transaction_created_at, transaction_updated_at]
      transaction = Hash[headers.zip(transaction_data)]
      @transactions.push transaction
    end
    return @transactions
  end

  def random
    format_transaction_data_into_hash
    @transactions.sample
  end

  def find_by(attribute, criteria)
    format_transaction_data_into_hash
    @results = []
    @transactions.each do |transaction|
      if transaction[attribute].downcase == criteria.downcase
      @results.push transaction
      end
    end
    return @results
  end

  def find_by_transaction_id(id)
    [] << find_by("transaction_id", id).first
  end

  def find_by_invoice_id(id)
    [] << find_by("invoice_id", id).first
  end

  def find_all_by_invoice_id(id)
    find_by("invoice_id", id)
  end

  def find_by_credit_card_number(number)
    [] << find_by("credit_card_number", number).first
  end

  def find_all_by_credit_card_number(number)
    find_by("credit_card_number", number)
  end

  # def find_by_credit_card_expiration_date(date)
  #   [] << find_by("credit_card_expiration_date", date).first
  # end

  # def find_all_by_credit_card_expiration_date(date)
  #   find_by("credit_card_expiration_date", date)
  # end

  def find_by_transaction_result(result)
    [] << find_by("transaction_result", result).first
  end

  def find_all_by_transaction_result(result)
    find_by("transaction_result", result)
  end

  def find_by_transaction_created_at(date)
    [] << find_by('transaction_created_at', date).first
  end

  def find_all_by_transaction_created_at(date)
    find_by('transaction_created_at', date)
  end

  def find_by_transaction_updated_at(date)
    [] << find_by('transaction_updated_at', date).first
  end

  def find_all_by_transaction_updated_at(date)
    find_by('transaction_updated_at', date)
  end

  def all
    format_transaction_data_into_hash
  end
end
