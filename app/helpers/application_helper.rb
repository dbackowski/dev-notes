module ApplicationHelper
  def is_admin?
    unless @logged_user.blank?
      @logged_user.admin
    end
  end

  def error_messages_for(object_name)
    model = instance_variable_get("@#{object_name}")
    
    unless model.nil? || model.errors.empty?  
      errors_list = capture do
        content_tag :ul do 
          model.errors.each do |attr,message|
            concat(content_tag :li, attr.capitalize.to_s + ' ' + message)
          end
        end
      end
      
      result = content_tag :h3, t(:header_message, :scope => 'error_messages_for', :default => 'Unable to save data.').html_safe 
      result << content_tag(:p, t(:error_list, :scope => 'error_messages_for', :default => 'Errors list:').html_safe)
      result << errors_list
      result = content_tag :div, result, :class => 'alert-message block-message error'
    end
  end

  def pretty_print(text)
    text.gsub!(/\n/, "<br />")
    text.gsub(/\[code\](.*?)\[\/code\]/m) { "<pre class=\"prettyprint\">#{$1.gsub("<br />", "\n")}</pre>" }.html_safe
  end
end
