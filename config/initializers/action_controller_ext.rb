class ActionController::Base
  
  private
  def flash_notice(resource, options = {})
    options.reverse_merge!(
      :action => action_name.to_sym,
      :class_name => resource.class.to_s.humanize.downcase,
      :name => resource.to_s
    )
    message = case options[:action]
    when :destroy
      "Deleted"
    when :update
      "Updated"
    else
      "Created"
    end
    flash[:notice] = "#{message} #{options[:class_name]} - \"#{options[:name]}\""
  end

end