require "stock-returns/version"
require 'csv'
require 'date'
require 'money'
require 'open-uri'

module StockReturns
  extend self

  LOOKBACK = 7

  def calculate(stock_symbol, purchase_date, options = {})
    purchase_date = Date.parse(purchase_date)

    purchase_price = if options[:purchase_price].nil?
      get_yahoo_price(stock_symbol, purchase_date)
    else
      Money.parse(options[:purchase_price])
    end

    sell_date = if options[:sell_date].nil?
      Date.today
    else
      Date.parse(options[:sell_date])
    end

    sell_price = if options[:sell_price].nil?
      get_yahoo_price(stock_symbol, sell_date)
    else
      Money.parse(options[:sell_price])
    end

    num_shares = options[:num_shares]

    total      = total_return(purchase_price, sell_price)
    annualized = annualized_return(total, purchase_date, sell_date)

    output(total, annualized)
  end

  private

  def output(total, annualized)
    { total_return:      "%.2f%" % (total * 100.0),
      annualized_return: "%.2f%" % (annualized * 100.0) }
  end

  def total_return(purchase_price, sell_price)
    (sell_price / purchase_price) - 1.0
  end

  def annualized_return(total, purchase_date, sell_date)
    num_days = (sell_date - purchase_date).to_i
    (total + 1.0)**(365.0 / num_days) - 1.0
  end

  def get_yahoo_price(stock_symbol, date)
    query = '?s=%s&a=%d&b=%d&c=%d&d=%d&e=%d&f=%d&g=d&ignore=.csv' %
      [stock_symbol, *yahoo_date(date - LOOKBACK), *yahoo_date(date)]
    url = 'http://ichart.yahoo.com/table.csv' + query

    csv   = open(url).read
    price = CSV.parse(csv, headers: true).first['Adj Close']
    Money.parse(price)
  end

  def yahoo_date(date)
    [date.month - 1, date.day, date.year]
  end
end
