require 'date'
require 'money'

module StockReturns
  module Calculator
    extend self

    def calculate(purchase_date, purchase_price, sell_date, sell_price)
      total      = total_return(purchase_price, sell_price)
      annualized = annualized_return(total, purchase_date, sell_date)

      { total_return:      "%.2f%" % (total * 100.0),
        annualized_return: "%.2f%" % (annualized * 100.0) }
    end

    private

    def total_return(purchase_price, sell_price)
      (sell_price / purchase_price) - 1.0
    end

    def annualized_return(total, purchase_date, sell_date)
      num_days = (sell_date - purchase_date).to_i
      (total + 1.0)**(365.0 / num_days) - 1.0
    end
  end
end
