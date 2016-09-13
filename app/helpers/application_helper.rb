module ApplicationHelper
  def change_for_bootstrap(name)
    if name == 'alert'
      'danger'
    elsif name == 'notice'
      'success'
    end
  end

  def active_link(name_of_controller, name_of_action)
    if controller_name == name_of_controller and controller.action_name == name_of_action
      'active'
    else
      ''
    end
  end

  def clear_error(error)
    "Вы #{error.split('Вы').last}"
  end

  def error_explanation_for(object)
    if object.errors.any?
      head = <<-EOF
    <div id="error_explanation">
      <h2>Будьте внимательнее, Вы допустили несколько ошибок:</h2>
      <ul>
      EOF
      foot = <<-EOF
      </ul>
    </div>
      EOF
      middle = object.errors.full_messages.inject("") do |m, error|
	m << "<li>#{ clear_error(error) }</li>"
      end
      (head << middle << foot).html_safe
    end
  end
end
