require 'date'
require 'money'
require 'optparse'

module Application
  extend self

  def run(argv)
    opts = Options.new(argv)

    options = {}
    options[:purchase_price] = opts.purchase_price unless opts.purchase_price.nil?
    options[:sell_date]      = opts.sell_date unless opts.sell_date.nil?
    options[:sell_price]     = opts.sell_price unless opts.sell_price.nil?

    stock_returns = StockReturns.new(opts.stock_symbol, opts.purchase_date, options)
    stock_returns.calculate
    puts stock_returns.print
  end

  class Options
    attr_reader :stock_symbol
    attr_reader :purchase_date
    attr_reader :purchase_price
    attr_reader :sell_date
    attr_reader :sell_price

    def initialize(argv)
      parse_opts(argv)
      @stock_symbol   = argv[0]
      @purchase_date  = Date.parse(argv[1])
      @purchase_price = parse_price(@purchase_price) unless @purchase_price.nil?
      @sell_date      = Date.parse(@sell_date) unless @sell_date.nil?
      @sell_price     = parse_price(@sell_price) unless @sell_price.nil?
    end

    private

    def parse_opts(argv)
      OptionParser.new do |opts|  
        opts.banner = "Usage: stock-returns stocksymbol purchasedate" +
                      " [-p purchaseprice] [-d selldate] [-s sellprice]"

        opts.on("-p", "--pp purchaseprice",
          String, "Stock purchase date") do |purchase_price|
          @purchase_price = purchase_price
        end

        opts.on("-d", "--sd selldate",
          String, "Stock sell date") do |sell_date|
          @sell_date = sell_date
        end

        opts.on("-s", "--sp sellprice",
          String, "Stock sell price") do |sell_price|
          @sell_price = sell_price
        end

        opts.on("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        begin
          argv = ["-h"] if argv.size < 2
          opts.parse!(argv)
        rescue OptionParser::ParseError => e
          STDERR.puts e.message, "\n", opts
          exit(-1)
        end
      end    
    end

    def parse_price(price)
      unless /^\$?\d+\.\d{2}$/ === price.to_s
        raise ArgumentError, "The price '#{price}' is not valid."
      end

      Money.parse(price)
    end
  end
end
