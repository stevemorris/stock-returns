require 'stock-returns/version'
require 'stock-returns/calculator'
require 'stock-returns/yahoo_finance'
require 'date'
require 'money'

module StockReturns
  extend self

  def calculate(stock_symbol, purchase_date, options = {})
    purchase_date = Date.parse(purchase_date)

    purchase_price = if options[:purchase_price].nil?
      YahooFinance.get_price(stock_symbol, purchase_date)
    else
      Money.parse(options[:purchase_price])
    end

    sell_date = if options[:sell_date].nil?
      Date.today
    else
      Date.parse(options[:sell_date])
    end

    sell_price = if options[:sell_price].nil?
      YahooFinance.get_price(stock_symbol, sell_date)
    else
      Money.parse(options[:sell_price])
    end

    Calculator.calculate(purchase_date, purchase_price, sell_date, sell_price)
  end
end
