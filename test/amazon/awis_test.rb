require File.dirname(__FILE__) + '/../test_helper'

class Amazon::AwisTest < Test::Unit::TestCase

  AWS_ACCESS_KEY_ID = ENV['AWS_ACCESS_KEY_ID']
  AWS_SECRET_KEY = ENV['AWS_SECRET_KEY']
  
  DOMAIN_STRING = 'yahoo.com'
  
  raise "Please specify set the AWS_ACCESS_KEY_ID environment variable" if AWS_ACCESS_KEY_ID.empty?
  raise "Please specify set the AWS_SECRET_KEY environment variable" if AWS_SECRET_KEY.empty?    
  
  Amazon::Awis.configure do |options|    
  	  options[:aws_access_key_id] = AWS_ACCESS_KEY_ID
  	  options[:aws_secret_key] = AWS_SECRET_KEY
  end
  
  Amazon::Awis.debug = true
  
  ## Test get_info
  def test_get_info  	  
  	  Amazon::Awis.configure do |options|
  	  	  options[:responsegroup] = 'Rank'
  	  end
  	  resp = Amazon::Awis.get_info(DOMAIN_STRING)     	  
  	  assert(resp.is_success?)  	  
  	  assert(resp.dataurl == 'yahoo.com/')
  	  assert(resp.rank.to_i > 0)
  end
   
  ## Test get_info with SiteData response group
  def test_site_data_response
  	  Amazon::Awis.configure do |options|    
  	  	  options[:responsegroup] = 'SiteData'  	  	   	  	 
  	  end
  	  resp = Amazon::Awis.get_info(DOMAIN_STRING)
  	  assert(resp.title == 'Yahoo!')
  	  assert(resp.onlinesince == '18-Jan-1995')
  end
  
  ## Test get_info with ContactInfo response group
  def test_contact_info_response
  	  Amazon::Awis.configure do |options|
  	  	  options[:responsegroup] = 'ContactInfo'
  	  end
	  resp = Amazon::Awis.get_info(DOMAIN_STRING)
	  assert(resp.symbol == 'YHOO')
  end
end
