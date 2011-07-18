class PagesController < ApplicationController

  def index
    @recent_notes = Note.limit(5).order('updated_at DESC')
    
    @oddities = []
    
    Master.all.each do |m|
      if m.notes.count == 0
        @oddities << { :message => "Master with no notes.", :master => m }
      end
    end
  end

  def data_entry
    @authority = Authority.new :region => Region.find_by_id( session[:last_country] )
    @region = Region.new
    @currency = Currency.new( :region => Region.find_by_id( session[:last_country] ), :authority => Authority.find_by_id( session[:last_authority] ) )
    @master = Master.new( :currency => Currency.find_by_id( session[:last_currency] ) )
    @note = Note.new( :master => Master.find_by_id( session[:last_master] ) )
  end
  
end
