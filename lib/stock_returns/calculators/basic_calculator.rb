module BasicCalculator
  extend self

  def calculate(purchase_price, sell_price, num_days)
    total      = total_return(purchase_price, sell_price)
    annualized = annualized_return(total, num_days)

    { total_return:      "%.2f%" % (total * 100.0),
      annualized_return: "%.2f%" % (annualized * 100.0) }
  end

  def print(returns)
    output =  "Total Return = #{returns[:total_return]}\n"
    output << "Annualized Return = #{returns[:annualized_return]}\n"
  end

  private

  def total_return(purchase_price, sell_price)
    (sell_price / purchase_price) - 1.0
  end

  def annualized_return(total, num_days)
    (total + 1.0)**(365.0 / num_days) - 1.0
  end
end
