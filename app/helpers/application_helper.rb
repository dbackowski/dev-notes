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
            concat(content_tag :li, message)
          end
        end
      end
      
      result = content_tag :h3, t(:header_message, :scope => 'error_messages_for', :default => 'Unable to save data.').html_safe 
      result << content_tag(:p, t(:error_list, :scope => 'error_messages_for', :default => 'Errors list:').html_safe)
      result << errors_list
      result = content_tag :div, result, :class => 'alert-message block-message error'
    end
  end
  
  def info(msg)
    content_tag(:div, msg, :class => 'alert-message block-message info')
  end

  def pretty_print(text)
    RedCloth.new(text.gsub(/@@@(.*?)@@@/m) { "<notextile><pre class=\"prettyprint\">#{$1}</pre></notextile>" }).to_html.html_safe
  end
end
