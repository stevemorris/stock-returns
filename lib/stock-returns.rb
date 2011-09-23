require 'date'
require 'money'
require_relative 'stock-returns/calculator'
require_relative 'stock-returns/yahoo_finance'

module StockReturns
  extend self

  def calculate(stock, purchase_date, options = {})
    verify_stock(stock)

    purchase_date  = set_date(purchase_date)
    purchase_price = set_price(options[:purchase_price], stock, purchase_date)
    sell_date      = set_date(options[:sell_date])
    sell_price     = set_price(options[:sell_price], stock, sell_date)

    Calculator.calculate(purchase_date, purchase_price, sell_date, sell_price)
  end

  private

  def verify_stock(stock)
    # verify with Yahoo
  end

  def set_date(date)
    if date.nil?
      Date.today
    else
      # verify and parse
      Date.parse(date)
    end
  end

  def set_price(price, stock, date)
    if price.nil?
      YahooFinance.get_price(stock, date)
    else
      # verify and parse
      Money.parse(price)
    end
  end
end
