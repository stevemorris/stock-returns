# Stock Returns Gem

A Ruby gem that calculates investment returns on individual US stocks.

Returns are adjusted for splits and dividends (except when using the optional arguments, for now).

Note: this is an Alpha version

## Installation and Usage

Clone the repo from GitHub and then build and install the gem locally:

    $ git clone git@github.com:stevemorris/stock-returns.git
    $ gem build stock-returns.gemspec
    $ gem install stock-returns-0.0.1.gem

Require the gem from your Ruby program or from IRB, and then call it:

    require 'stock-returns'
    
    StockReturns.calculate('AAPL', '2001-10-23')

[The example above tells you what your investment return would have been if you had bought Apple stock on the day of the iPod 1 announcement and held it to today.]

The StockReturns.calculate method returns a hash containing the total return and the annualized return.

## Required and Optional Arguments

    StockReturns.calculate(stock_symbol, purchase_date, options = {})
    
stock_symbol (required)

purchase_date (required): yyyy-mm-dd

purchase_price (optional): if not provided, defaults to closing price on purchase date

    purchase_price: '12.34'

sell_date (optional): if not provided, defaults to most recent closing date

    sell_date: '2011-09-01'

sell_price (optional): if not provided, defaults to closing price on sell date

    sell_price: '23.45'

num_shares (optional): not used yet


    
