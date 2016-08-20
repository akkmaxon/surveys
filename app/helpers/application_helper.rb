module ApplicationHelper
  def change_for_bootstrap(name)
    if name == 'alert'
      'danger'
    elsif name == 'notice'
      'success'
    end
  end
end
