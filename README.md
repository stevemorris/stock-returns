# Stock Returns Gem

A Ruby gem that calculates investment returns on individual US stocks.

Returns are adjusted for splits and dividends, except when calling the gem with the optional arguments.

## Installation

Clone the repo from GitHub and then build and install the gem locally:

    $ git clone git@github.com:stevemorris/stock-returns.git
    $ gem build stock-returns.gemspec
    $ gem install stock-returns-0.0.5.gem

## Usage and examples

    StockReturns.calculate(stock_symbol, purchase_date, options = {})

To see what your return would have been if you had bought Apple stock on the day of the iPod 1 announcement and held it to today, create and run the following Ruby program:

    require 'stock-returns'
    require 'date'
    
    StockReturns.calculate('AAPL', Date.parse('2001-10-23'))

Below is an alternate version of the program above using a *StockReturns::Engine* object:

    require 'stock-returns'
    require 'date'

    stock_returns = StockReturns::Engine.new('AAPL', Date.parse('2001-10-23'))
    stock_returns.calculate

Below is an example program using the common optional arguments:

    require 'stock-returns'
    require 'date'
    require 'money'

    StockReturns.calculate('AAPL', Date.parse('2011-1-3'), purchase_price: Money.parse(329.57), sell_date: Date.parse('2011-9-1'), sell_price: Money.parse(381.03))

## Required arguments to *calculate* method
    
### stock_symbol

String object, example:

    'GOOG'

### purchase_date

Date object, example:

    Date.parse('2010-12-30')

## Optional arguments to *calculate* method

### purchase_price: purchaseprice

Money object from the Ruby Money gem, example:

    purchase_price: Money.parse('12.34')

### sell_date: selldate

Date object, example:

    sell_date: Date.parse('2010-12-30')

### sell_price: sellprice

Money object from the Ruby Money gem, example:

    sell_price: Money.parse('12.34')

### data_source: datasource

Object that defines the custom data source methods (see *Defining a custom data source* below), example:

    data_source: MyDataSource


## Return object from *calculate* method

The *calculate* method returns a hash object containing the total return and annualized return calculated by the gem. For example:

    {:total_return=>"50.00%", :annualized_return=>"5.88%"}

## Command line interface

The gem can also be run from the command line by executing the *stock-returns* program.

Example:

    stock-returns GOOG 2004-8-19

Example with optional arguments:

    stock-returns AAPL 2011-1-3 --pp 329.57 --sd 2011-9-1 --sp 381.03

## Defining a custom data source

Below is a Ruby object that implements a custom data source for stock prices, showing the two required methods that must be defined. A custom data source object can be passed to the *calculate* method using the *data_source:* argument.

    module MyDataSource # Can change this name
      
      def self.get_price(stock_symbol, date)
        # Return the stock price as a Money object
      end
      
      def self.verify_stock(stock_symbol)
        # Return true if stock_symbol is valid, false otherwise
      end
    end
