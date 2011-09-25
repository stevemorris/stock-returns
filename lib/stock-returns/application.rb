module StockReturns
  class Application
    def self.run(argv)
      options       = parse_options(argv)
      stock_symbol  = argv[0]
      purchase_date = Date.parse(argv[1])

      stock_returns = Engine.new(stock_symbol, purchase_date, options)
      stock_returns.calculate
      puts stock_returns.print
    end

    private

    def self.parse_options(argv)
      options = {}

      OptionParser.new do |opts|
        opts.banner = 'Usage: stock-returns stocksymbol purchasedate' +
                      ' [-p purchaseprice] [-d selldate] [-s sellprice]'

        opts.on('-p', '--pp purchaseprice',
                'Stock purchase price') do |purchase_price|
          options[:purchase_price] = parse_price(purchase_price)
        end

        opts.on('-d', '--sd selldate', 'Stock sell date') do |sell_date|
          options[:sell_date] = Date.parse(sell_date)
        end

        opts.on('-s', '--sp sellprice', 'Stock sell price') do |sell_price|
          options[:sell_price] = parse_price(sell_price)
        end

        opts.on('-h', '--help', 'Show this message') do
          puts opts
          exit
        end

        begin
          argv = ['-h'] if argv.size < 2
          opts.parse!(argv)
        rescue OptionParser::ParseError => e
          STDERR.puts e.message, "\n", opts
          exit(-1)
        end
      end

      options
    end

    def self.parse_price(price)
      unless /^\$?\d+\.\d{2}$/ === price.to_s
        raise ArgumentError, "The price '#{price}' is not valid."
      end
      Money.parse(price)
    end
  end
end
