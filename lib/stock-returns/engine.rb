module StockReturns
  class Engine
    def initialize(stock_symbol, purchase_date, options = {})
      options = {
        calculator:  BasicCalculator,
        data_source: YahooFinance,
        sell_date:   Date.today
      }.merge(options)

      @calculator     = options[:calculator]
      @data_source    = options[:data_source]
      @stock_symbol   = verify_stock(stock_symbol)
      @purchase_date  = verify_date(purchase_date)
      @purchase_price = verify_price(options[:purchase_price])
      @sell_date      = verify_date(options[:sell_date])
      @sell_price     = verify_price(options[:sell_price])
      @returns        = nil
    end

    def calculate
      if @purchase_price.nil?
        @purchase_price = @data_source.get_price(@stock_symbol, @purchase_date)
      end

      if @sell_price.nil?
        @sell_price = @data_source.get_price(@stock_symbol, @sell_date)
      end

      num_days = (@sell_date - @purchase_date).to_i
      @returns = @calculator.calculate(@purchase_price, @sell_price, num_days)
    end

    def print
      @calculator.print(@returns)
    end

    private

    def verify_stock(stock_symbol)
      unless @data_source.verify_stock(stock_symbol)
        raise ArgumentError, "Stock symbol '#{stock_symbol}' was not found."
      end
      stock_symbol
    end

    def verify_date(date)
      unless date.kind_of?(Date)
        raise ArgumentError, "'#{date}' must be a Date object. See README."
      end
      date
    end

    def verify_price(price)
      unless price.kind_of?(Money) || price.nil?
        raise ArgumentError, "'#{price}' must be a Money object. See README."
      end
      price
    end
  end
end
