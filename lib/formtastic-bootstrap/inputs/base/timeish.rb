module FormtasticBootstrap
  module Inputs
    module Base
      module Timeish

        def date_input_html
          fragments.inject([]) do |arr,fragment|
            arr << fragment_input_html(fragment)
           end.join.html_safe
        end
        
        def datetime_input_html
          fragments.inject([]) do |arr,fragment|
            arr << " : " if fragment == :minute
            arr << " - " if fragment == :hour
            arr << fragment_input_html(fragment)
            arr
           end.join.html_safe
        end
        
        def fragment_input_html(fragment)
          opts = input_options.merge(:prefix => object_name, :field_name => fragment_name(fragment), :default => value, :include_blank => false)
          template.send(:"select_#{fragment}", value, opts, input_html_options.merge(:id => fragment_id(fragment),:class => "datetime-#{fragment}" ))
        end
        
      end
    end
  end
end
