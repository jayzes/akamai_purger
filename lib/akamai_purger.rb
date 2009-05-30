require 'rubygems'
require 'optparse'
require 'soap/wsdlDriver'

class AkamaiPurger
  
  WSDL_URL = "https://ccuapi.akamai.com/ccuapi-axis.wsdl"
  
  def initialize(args)
    opts = OptionParser.new do |opts|
      opts.banner = "Usage: #{File.basename($0)} [options]"

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
      
      opts.on('-l', '--url [URL]', "Specifies the URL to purge.") do |url|
        @url = url
      end
      
      
    end
    
    @args = opts.parse!(args)
  end
  
  def run
    
    puts "User, password, and URL must be supplied!" unless @username && @password && @url
    
    puts "Sending purge request for #{@url}."
    driver = SOAP::WSDLDriverFactory.new(WSDL_URL).create_rpc_driver
    driver.options["protocol.http.basic_auth"] << [WSDL_URL, @username, @password]
    result = driver.purgeRequest(@username, @password, '', [], @url)
    
    puts "Purge request #{ result.resultCode == '100' ? 'was successful' : 'failed' }."
  end
end