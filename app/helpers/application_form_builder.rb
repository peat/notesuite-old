class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  helpers = field_helpers +
            %w{date_select submit datetime_select time_select} +
            %w{collection_select select country_select time_zone_select} -
            %w{hidden_field label fields_for} # Don't decorate these

  no_label = %w{submit}

  helpers.each do |name|
    define_method(name) do |field, *args|
      options = args.last.is_a?(Hash) ? args.pop : {}

      content = ''

      unless no_label.include? name
        # fancy gsub below is to capitalize every word in the label
        label_text = ( options[:label] || field.to_s.humanize.gsub(/\b\w/){$&.upcase} ) + ':'
        
        # required field highlighting
        if options[:required]
          options[:label_class] = (options[:label_class] || '') + " required"
        end
        
        content = label(field, label_text, :class => options[:label_class] )
      end

      content << super( field, *args )

      # center the create or update buttons
      if name == 'submit'
        content = @template.content_tag(:div, content.html_safe, :class => 'center')
      end

      @template.content_tag(:li, content )
    end
  end
    
end