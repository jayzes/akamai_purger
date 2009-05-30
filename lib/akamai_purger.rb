require 'rubygems'
require 'optparse'
require 'cgi'
require 'soap/wsdlDriver'

class AkamaiPurger
  
  WSDL_URL = "https://ccuapi.akamai.com/ccuapi-axis.wsdl"
  
  def initialize(args)
    opts = OptionParser.new do |opts|
      opts.banner = "Usage: #{File.basename($0)} [options] URLs"

      opts.on('-h', '--help', 'Show this message') do
        puts opts
        exit 1
      end
      
      opts.on('-u', '--user [USER]', 'Specifies the Akamai username to connect as.') do |user|
        @username = user
      end
      
      opts.on('-p', '--password [PASSWORD]', "Specifies the password for the Akamai user.") do |pass|
        @password = pass
      end
      
      opts.on('-e', '--email [EMAILS]', "Specifies the e-mail addresses (comma separated) to receive the purge notification.") do |emails|
        @emails = emails
      end
      
    end
    
    @args = opts.parse!(args)
    @urls = args.join(',')
  end
  
  def assemble_options
    options = []
    options << "email-notification=#{@emails}" if @emails
    options
  end
  
  def run
    unless @username && @password && @urls
      puts "User, password, and URLs must be supplied!" 
      exit 1
    end
    
    puts "Sending purge request for #{@urls}..."
    driver = SOAP::WSDLDriverFactory.new(WSDL_URL).create_rpc_driver
    driver.options["protocol.http.basic_auth"] << [WSDL_URL, @username, @password]
    result = driver.purgeRequest(@username, @password, '', assemble_options, @urls.split(','))
    
    if result.resultCode == '100'
      puts "Purge request was successful.  Purge should be complete within #{result.estTime.to_i/60} minutes."
    else
      puts "Purge request failed with the message '#{result.resultMsg}'."
    end
  end
end