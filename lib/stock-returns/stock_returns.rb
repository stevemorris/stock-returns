module StockReturns
  extend self

  def calculate(stock_symbol, purchase_date, options = {})
    stock_returns = Engine.new(stock_symbol, purchase_date, options)
    stock_returns.calculate
  end
end
