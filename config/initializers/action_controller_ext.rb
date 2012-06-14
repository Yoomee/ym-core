class ActionController::Base

  helper_method :current_path
  
  def action_name_with_string_inquirer
    ActiveSupport::StringInquirer.new(action_name_without_string_inquirer)
  end
  alias_method_chain :action_name, :string_inquirer
  
  def controller_name_with_string_inquirer
    ActiveSupport::StringInquirer.new(controller_name_without_string_inquirer)
  end
  alias_method_chain :controller_name, :string_inquirer
  
  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end  
  
  def return_or_redirect_to(*args)
    if params[:return_to]
      redirect_to(params[:return_to])
    else
      redirect_to(*args)
    end
  end
  
  def current_path
    out = request.path.dup
    query_string = request.query_string
    query_string.present? ?  "#{out}?#{query_string}" : out
  end
  
  private
  def flash_error(resource, options = {})
    flash_message(:error, resource, options)
  end
  
  def flash_notice(resource, options = {})
    flash_message(:notice, resource, options)
  end
  
  def flash_message(key, resource, options = {})
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
    flash[key] = "#{message} #{options[:class_name]} - \"#{options[:name]}\""
  end

end