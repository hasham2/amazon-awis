#--
# Copyright (c) 2009 Hasham Malik
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

require "cgi"
require "base64"
require "openssl"
require "digest/sha1"
require "uri"
require "net/https"
require "rexml/document"
require "time"
require "hpricot"

module Amazon
  
  class RequestError < StandardError; end
  
  class Awis
  	  
    @@options = {
    	    :action => "UrlInfo",
    	    :responsegroup => "Rank"
    }
    
    @@debug = false

    # Default service options
    def self.options
    	    @@options
    end
    
    # Set default service options
    def self.options=(opts)
    	    @@options = opts
    end
    
    # Get debug flag.
    def self.debug
    	    @@debug
    end
    
    # Set debug flag to true or false.
    def self.debug=(dbg)
    	    @@debug = dbg
    end
    
    def self.configure(&proc)
    	    raise ArgumentError, "Block is required." unless block_given?
    	    yield @@options
    end
    
    def self.get_info(domain)    
    	    url = self.prepare_url(domain)
    	    log "Request URL: #{url}"
    	    res = Net::HTTP.get_response(url)
    	    unless res.kind_of? Net::HTTPSuccess
    	    	    raise Amazon::RequestError, "HTTP Response: #{res.code} #{res.message}"
    	    end
    	    log "Response text: #{res.body}"
    	    Response.new(res.body)
    end	    
	        
    
    # Response object returned after a REST call to Amazon service.
    class Response
      # XML input is in string format
      def initialize(xml)
      	      @doc = Hpricot(xml)
      end

      # Return Hpricot object.
      def doc
      	      @doc
      end

      # Return true if response has an error.
      def has_error?
      	      !(is_success?)
      end

      # Return error message.
      def is_success?
      	      (@doc/"aws:statuscode").innerHTML == "Success"     	      	      
      end
      
            
      # Return traffic rank.
      def traffic_rank      	      
      	      unless @traffic_rank
      	      	      @trafic_rank = (@doc/"aws:rank").innerHTML.to_i
      	      end
      	      @trafic_rank
      end
    end
    
    protected
    
    def self.log(s)
    	    return unless self.debug
    	    if defined? RAILS_DEFAULT_LOGGER
    	    	    RAILS_DEFAULT_LOGGER.error(s)
    	    elsif defined? LOGGER
    	    	    LOGGER.error(s)
    	    else
    	    	    puts s
    	    end
    end
      
    private 
    
    def self.prepare_url(domain)
    	    
    	    timestamp = ( Time::now ).utc.strftime("%Y-%m-%dT%H:%M:%S.000Z")    	    
    	    secret_key = secret_key = self.options.delete(:aws_secret_key)    	    
    	    action = self.options.delete(:action)    	    
    	    signature = Base64.encode64( OpenSSL::HMAC.digest( OpenSSL::Digest::Digest.new( "sha1" ), secret_key, action + timestamp)).strip    	    
    	    url = URI.parse("http://awis.amazonaws.com/?" +
    	    	    	{
    	    	    		"Action"       => action,
    	    	    		"AWSAccessKeyId"  => self.options[:aws_access_key_id],
    	    	    		"Signature"       => signature,
    	    	    		"Timestamp"       => timestamp,
    	    	    		"ResponseGroup"   => self.options[:responsegroup],
    	    	    		"Url"           => domain
          		}.to_a.collect{|item| item.first + "=" + CGI::escape(item.last) }.join("&")
          		)
            return url
    	    
    end
     
  end

  # Internal wrapper class to provide convenient method to access Hpricot element value.
  class Element
    # Pass Hpricot::Elements object
    def initialize(element)
    	    @element = element
    end

    # Returns Hpricot::Elments object    
    def elem
    	    @element
    end
    
    # Find Hpricot::Elements matching the given path. Example: element/"author".
    def /(path)
    	    elements = @element/path
    	    return nil if elements.size == 0
    	    elements
    end
    
    # Find Hpricot::Elements matching the given path, and convert to Amazon::Element.
    # Returns an array Amazon::Elements if more than Hpricot::Elements size is greater than 1.
    def search_and_convert(path)
    	    elements = self./(path)
    	    return unless elements
    	    elements = elements.map{|element| Element.new(element)}
    	    return elements.first if elements.size == 1
    	    elements
    end

    # Get the text value of the given path, leave empty to retrieve current element value.
    def get(path='')
    	    Element.get(@element, path)
    end
    
    # Get the unescaped HTML text of the given path.
    def get_unescaped(path='')
    	   Element.get_unescaped(@element, path)
    end
    
    # Get the array values of the given path.
    def get_array(path='')
      	   Element.get_array(@element, path)
    end

    # Get the children element text values in hash format with the element names as the hash keys.
    def get_hash(path='')
      	   Element.get_hash(@element, path)
    end

    # Similar to #get, except an element object must be passed-in.
    def self.get(element, path='')
      	   return unless element
           result = element.at(path)
           result = result.inner_html if result
           result
    end
    
    # Similar to #get_unescaped, except an element object must be passed-in.    
    def self.get_unescaped(element, path='')
           result = get(element, path)
           CGI::unescapeHTML(result) if result
    end

    # Similar to #get_array, except an element object must be passed-in.
    def self.get_array(element, path='')
          return unless element
      
          result = element/path
          if (result.is_a? Hpricot::Elements) || (result.is_a? Array)
          	  parsed_result = []
          	  result.each {|item|
          	  	  parsed_result << Element.get(item)
          	  }
          	  parsed_result
          else
          	  [Element.get(result)]
          end
    end

    # Similar to #get_hash, except an element object must be passed-in.
    def self.get_hash(element, path='')
    	    return unless element
    
    	    result = element.at(path)
    	    if result
    	    	    hash = {}
    	    	    result = result.children
    	    	    result.each do |item|
    	    	    	    hash[item.name.to_sym] = item.inner_html
    	    	    end 
    	    	    hash
    	    end
    end
    
    def to_s
    	    elem.to_s if elem
    end
  end
end