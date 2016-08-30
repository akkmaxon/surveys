module ApplicationHelper
  def set_class_for_layout
    if devise_controller? then 'col-md-6 col-md-offset-3'
    elsif controller_name == 'surveys' then 'col-sm-12'
    else 'col-md-8 col-md-offset-2'
    end
  end

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
