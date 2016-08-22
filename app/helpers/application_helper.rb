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
end
