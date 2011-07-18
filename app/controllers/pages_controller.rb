class PagesController < ApplicationController

  def index
    @recent_notes = Note.limit(5).order('updated_at DESC')
    
    @oddities = []
    
    # find masters without any notes
    Master.includes(:notes).all.each do |m|
      if m.notes.count == 0
        @oddities << { :message => "Master with no Notes.", :master => m }
      end
    end
    
    # find currencies without any masters
    Currency.includes(:masters).all.each do |c|
      if c.masters.count == 0
        @oddities << { :message => "Currency with no Masters.", :currency => c }
      end
    end
    
    # find authorities without masters
    Authority.includes(:masters).all.each do |a|
      if a.masters.count == 0
        @oddities << { :message => "Authority with no Masters.", :authority => a }
      end
    end
    
    Region.includes(:masters).all.each do |r|
      if r.children.blank? and r.masters.count == 0
        @oddities << { :message => "Region with no Masters.", :region => r }
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
