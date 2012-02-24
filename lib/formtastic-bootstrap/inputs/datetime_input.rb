module FormtasticBootstrap
  module Inputs
    class DatetimeInput < Formtastic::Inputs::DatetimeInput
      include Base
      include Base::Stringish
      include Base::Timeish

      def to_html
        generic_input_wrapping do
          inline_inputs_div_wrapping do
            # This newline matters.
            datetime_input_html
          end
        end
      end

    end
  end
end