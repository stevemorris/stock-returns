# Stock Returns Gem

A Ruby gem that calculates investment returns on individual US stocks.

Returns are adjusted for splits and dividends (except when using the optional arguments, for now).

Note: this is an Alpha version

## Installation and Usage

Clone the repo from GitHub and then build and install the gem locally:

    $ git clone git@github.com:stevemorris/stock-returns.git
    $ gem build stock-returns.gemspec
    $ gem install stock-returns-0.0.3.gem

Require the gem from your Ruby program or from IRB, and then call it:

    require 'stock-returns'
    
    StockReturns.calculate('AAPL', '2001-10-23')

[The example above shows you what your investment return would have been if you had bought Apple stock on the day of the iPod 1 announcement and held it to today.]

The StockReturns.calculate method returns a hash containing the total return and the annualized return.

## Required and Optional Arguments

    StockReturns.calculate(stock_symbol, purchase_date, options = {})
    
Required: *stock_symbol*

Required: *purchase_date* [format: 'yyyy-mm-dd']

Optional: *purchase_price: $$.cc* [if not provided, defaults to the closing price on the purchase date]

    purchase_price: 12.34

Optional: *sell_date: 'yyyy-mm-dd'* [if not provided, defaults to the most recent closing date]

    sell_date: '2011-09-01'

Optional: *sell_price: $$.cc*  [if not provided, defaults to the closing price on the sell date]

    sell_price: 23.45

Example with optional arguments:

    StockReturns.calculate('AAPL', '2011-1-3', purchase_price: 329.57, sell_date: '2011-9-1', sell_price: 381.03)

## Command Line Interface

The gem can also be run from the command line by executing the *stock-returns* program.

Example:

    stock-returns GOOG 2004-8-19

Example with optional arguments:

    stock-returns AAPL 2011-1-3 --pp 329.57 --sd 2011-9-1 --sp 381.03
