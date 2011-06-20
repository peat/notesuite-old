# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def create_or_update( obj )
    obj.new_record? ? 'Create' : 'Update'
  end
  
  def icon( name )
    image_tag("/icons/silk/#{name}.png")
  end

  def year( date )
    date.try(:year)
  end

  def n( num )
    suffix = ""
    
    if      num > 1_000_000_000_000 # trillion
      num = num / 1_000_000_000_000
      suffix = "T"
    elsif   num > 1_000_000_000 # billion
      num = num / 1_000_000_000
      suffix = "B"
    elsif   num > 1_000_000 # million
      num = num / 1_000_000
      suffix = "M"
    end
    
    "#{number_with_delimiter( num )}#{suffix}"
  end
  
  def link_to_master( m )
    
    link_to name_for_master(m), m
  end
  
  def name_for_master( m )
    if m.code.blank?
      "#{m.country.name} #{n(m.denomination)} #{m.currency.unit}"
    else
      "#{m.country.name} #{m.code}"
    end
  end

  def inv_count( m )
    count = m.notes.count
    if count == 2
      "<span class=\"complete\">#{count}</span>".html_safe
    else
      count
    end
  end

end
