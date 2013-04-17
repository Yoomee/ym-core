module ActionView
  module Helpers
    module UrlHelper
      def link_to_with_icon(*args, &block)
        html_options = args[2] || {}
        if !block_given? && (icon = html_options.delete(:icon))
          args[0] = "<i class='icon-#{icon}'></i> #{args[0]}".strip.html_safe
          args[2] = html_options
        end
        link_to_without_icon(*args, &block).html_safe
      end 
      alias_method_chain :link_to, :icon
    end 
  end 
end