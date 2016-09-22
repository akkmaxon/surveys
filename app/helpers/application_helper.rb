module ApplicationHelper
  def change_for_bootstrap(name)
    if name == 'alert'
      'danger'
    elsif name == 'notice'
      'success'
    end
  end

  def active_link(name_of_controller)
    if controller_name == name_of_controller
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
    <div class="panel panel-danger">
      <div class="panel-heading">
	<h2 class="h4">Допущенные ошибки:</h2>
      </div>
      <div class="panel-body">
	<ul>
      EOF
      foot = <<-EOF
	</ul>
      </div>
    </div>
      EOF
      middle = object.errors.full_messages.inject("") do |m, error|
	m << "<li>#{ clear_error(error) }</li>"
      end
      (head << middle << foot).html_safe
    end
  end
end
