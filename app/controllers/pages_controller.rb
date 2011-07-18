class PagesController < ApplicationController

  def index
    @recent_notes = Note.limit(5).order('updated_at DESC')
    
    @oddities = []
        
    # masters w/o notes
    Master.find_by_sql("SELECT * FROM masters WHERE id NOT IN (SELECT DISTINCT master_id FROM notes)").each do |m|
      @oddities << { :message => "Master with no Notes.", :master => m }
    end
    
    # masters w/o issuing dates
    Master.find_by_sql("SELECT * FROM masters WHERE issued_on IS NULL").each do |m|
      @oddities << { :message => "Master with no issue date.", :master => m }
    end
    
    # masters w/o codes
    Master.find_by_sql("SELECT * FROM masters WHERE code IS NULL or code=''").each do |m|
      @oddities << { :message => "Master has no code.", :master => m }
    end
    
    # notes w/o masters
    Note.find_by_sql("SELECT * FROM notes WHERE master_id IS NULL OR master_id NOT IN (SELECT DISTINCT id FROM masters)").each do |n|
      @oddities << { :message => "Note without Master.", :note => n }
    end
    
    # find currencies without any masters or overprints!
    Currency.find_by_sql("SELECT * FROM currencies WHERE id NOT IN (SELECT DISTINCT currency_id FROM masters) AND id NOT IN (SELECT DISTINCT overprint_currency_id FROM masters)").each do |c|
      @oddities << { :message => "Currency with no Masters.", :currency => c }
    end
    
    # find authorities without currencies
    Authority.find_by_sql("SELECT * FROM authorities WHERE id NOT IN (SELECT DISTINCT authority_id FROM currencies)").each do |a|
      @oddities << { :message => "Authority with no Currencies.", :authority => a }
    end
    
    # find authorities without regions?
    Authority.find_by_sql("SELECT * FROM authorities WHERE region_id IS NULL OR region_id NOT IN (SELECT DISTINCT id FROM regions)").each do |a|
      @oddities << { :message => "Authority with no Region.", :authority => a }
    end
    
    # find regions without authorities
    Region.find_by_sql("SELECT * FROM regions WHERE id NOT IN (SELECT DISTINCT region_id FROM authorities)").each do |r|
      @oddities << { :message => "Region with no Authorities.", :region => r }
    end
    
    # find orphaned regions
    Region.find_by_sql("SELECT * FROM regions WHERE parent_id IS NULL OR parent_id NOT IN (SELECT DISTINCT id FROM regions) ").each do |r|
      @oddities << { :message => "Region without Parent.", :region => r }
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
