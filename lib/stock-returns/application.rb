require 'optparse'

module StockReturns
  module Application
    extend self

    def run(argv)
      opts = Options.new(argv)

      returns = StockReturns.calculate(opts.stock_symbol, opts.purchase_date,
        { purchase_price: opts.purchase_price, sell_date: opts.sell_date,
          sell_price: opts.sell_price })

      puts "Total Return = #{returns[:total_return]}"
      puts "Annualized Return = #{returns[:annualized_return]}"
    end

    class Options
      attr_reader :stock_symbol
      attr_reader :purchase_date
      attr_reader :purchase_price
      attr_reader :sell_date
      attr_reader :sell_price

      def initialize(argv)
        parse_opts(argv)
        @stock_symbol  = argv[0]
        @purchase_date = argv[1]
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
    end
  end
end
