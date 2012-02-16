module FormtasticBootstrap
  module Inputs
    module Base
      module Timeish

        def label_html
          # TODO Supress the "for" field?
          template.content_tag(:label, label_html_options) do
            render_label? ? label_text : "".html_safe
          end
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