class PagesController < ApplicationController

  def index
    @authority = Authority.new :country => Country.find_by_id( session[:last_country] )
    @country = Country.new
    @currency = Currency.new( :country => Country.find_by_id( session[:last_country] ), :authority => Authority.find_by_id( session[:last_authority] ) )
    @master = Master.new( :currency => Currency.find_by_id( session[:last_currency] ) )
    @note = Note.new( :master => Master.find_by_id( session[:last_master] ) )
  end
  
end
