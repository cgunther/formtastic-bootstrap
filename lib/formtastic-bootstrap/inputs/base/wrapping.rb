module FormtasticBootstrap
  module Inputs
    module Base
      module Wrapping

        include Formtastic::Inputs::Base::Wrapping

        def generic_input_wrapping(&block)
          control_group_div_wrapping do
            label_html <<
            input_div_wrapping do
              if options[:prepend] || options[:append]
                content = [yield]
                wrapper_classes = []
                
                if options[:prepend]
                  content.unshift input_add_on(options[:prepend])
                  wrapper_classes << 'input-prepend'
                end

                if options[:append]
                  content << input_add_on(options[:append])
                  wrapper_classes << 'input-append'
                end
                
                template.content_tag(:div, content.join.html_safe, :class => wrapper_classes)
              else
                yield
              end
            end
          end
        end
        
        def input_add_on(content)
          template.content_tag(:span, content, :class => 'add-on')
        end

        def control_group_div_wrapping(&block)
          template.content_tag(:div, wrapper_html_options) do
            yield
          end
        end

        def input_div_wrapping(inline_or_block_errors = :inline)
          template.content_tag(:div, :class => "controls") do
            [yield, error_html(inline_or_block_errors), hint_html(inline_or_block_errors)].join("\n").html_safe
          end
        end

        def inline_inputs_div_wrapping(&block)
          template.content_tag(:div, :class => "inline-inputs") do
            yield
          end
        end

        def wrapper_html_options
          opts = (options[:wrapper_html] || {}).dup
          opts[:class] =
            case opts[:class]
            when Array
              opts[:class].dup
            when nil
              []
            else
              [opts[:class].to_s]
            end
          opts[:class] << as
          opts[:class] << "control-group"
          # opts[:class] << "input"
          opts[:class] << "error" if errors?
          opts[:class] << "optional" if optional?
          opts[:class] << "required" if required?
          opts[:class] << "autofocus" if autofocus?
          opts[:class] = opts[:class].join(' ')

          opts[:id] ||= wrapper_dom_id

          opts
        end
      end
      
    end
  end
end
