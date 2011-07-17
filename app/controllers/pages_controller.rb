class PagesController < ApplicationController

  def data_entry
    @authority = Authority.new :region => Region.find_by_id( session[:last_country] )
    @region = Region.new
    @currency = Currency.new( :region => Region.find_by_id( session[:last_country] ), :authority => Authority.find_by_id( session[:last_authority] ) )
    @master = Master.new( :currency => Currency.find_by_id( session[:last_currency] ) )
    @note = Note.new( :master => Master.find_by_id( session[:last_master] ) )
  end
  
end
