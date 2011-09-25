module StockReturns
  module YahooFinance
    extend self

    LOOKBACK_DAYS = 7

    def get_price(stock_symbol, date)
      query = sprintf('?s=%s&a=%d&b=%d&c=%d&d=%d&e=%d&f=%d&g=d&ignore=.csv',
        stock_symbol, *yahoo_date(date - LOOKBACK_DAYS), *yahoo_date(date))
      url   = 'http://ichart.yahoo.com/table.csv' + query

      csv   = open(url).read
      price = CSV.parse(csv, headers: true).first['Adj Close']
      Money.parse(price)
    end

    def verify_stock(stock_symbol)
      query = "?s=#{stock_symbol}&f=ne1"
      url   = 'http://download.finance.yahoo.com/d/quotes.csv' + query

      !open(url).read.include?('No such ticker symbol')
    end

    private

    def yahoo_date(date)
      [date.month - 1, date.day, date.year]
    end
  end
end
