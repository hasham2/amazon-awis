require File.dirname(__FILE__) + '/../test_helper'

class Amazon::AwisTest < Test::Unit::TestCase

  AWS_ACCESS_KEY_ID = 'AWS_ACCESS_KEY_ID'
  AWS_SECRET_KEY = 'AWS_SECRET_KEY'
  
  raise "Please specify set your AWS_ACCESS_KEY_ID" if AWS_ACCESS_KEY_ID.empty?
  raise "Please specify set your AWS_SECRET_KEY" if AWS_SECRET_KEY.empty?
  
  Amazon::Awis.configure do |options|    
    options[:aws_access_key_id] = AWS_ACCESS_KEY_ID
    options[:aws_secret_key] = AWS_SECRET_KEY
  end
  
  Amazon::Awis.debug = true
  
  ## Test get_info
  def test_get_info
  	  resp = Amazon::Awis.get_info('yahoo.com')     	  
  	  assert(resp.is_success?)
  	  puts resp.get('dataurl')
  	  assert(resp.get('dataurl') == 'yahoo.com/')
  	  assert(resp.traffic_rank == 3)    
  end
  
  
 
end
