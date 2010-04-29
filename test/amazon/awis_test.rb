require File.dirname(__FILE__) + '/../test_helper'

class Amazon::AwisTest < Test::Unit::TestCase

  AWS_ACCESS_KEY_ID = ''
  AWS_SECRET_KEY = ''
  
  DOMAIN_STRING = 'yahoo.com'
  
  raise "Please specify set your AWS_ACCESS_KEY_ID" if AWS_ACCESS_KEY_ID.empty?
  raise "Please specify set your AWS_SECRET_KEY" if AWS_SECRET_KEY.empty?
  
  Amazon::Awis.configure do |config|
    config[:aws_access_key_id] = AWS_ACCESS_KEY_ID
    config[:aws_secret_key] = AWS_SECRET_KEY
  end
  
  Amazon::Awis.debug = true
    
  def setup
    @awis = Amazon::Awis.new({
      :domain => DOMAIN_STRING
    })
  end
  
  ## Test get_info
  def test_query
    resp = @awis.query(:rank)

    assert(resp.is_success?)  	  
    assert(resp.dataurl == 'yahoo.com/')
    assert(resp.rank == 4.to_s)    
  end
   
  # Test get_info with SiteData response group
  def test_site_data_response
    resp = @awis.query(:site_data)

    assert(resp.is_success?)
    assert(resp.title == 'Yahoo!')
    assert(resp.onlinesince == '18-Jan-1995')
  end
  
  ## Test get_info with ContactInfo response group
  def test_contact_info_response
    resp = @awis.query(:contact_info)
    
    assert(resp.is_success?)
    assert(resp.symbol == 'YHOO')
  end
  
  def test_with_another_domain
    @awis.options[:domain] = 'google.com/'
    
    resp = @awis.query(:rank)
    
    assert(resp.is_success?)
    assert(resp.dataurl == 'google.com/')
    assert(resp.rank == 1.to_s)
  end
end
