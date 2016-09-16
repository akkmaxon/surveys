module Admin::CoordinatorsHelper
  def render_coordinator
    if session.key?(:coordinator_credentials)
      coordinator = <<-COORDINATOR
      <div class="panel panel-default" id="coordinator_credentials">
        <div class="panel-heading text-center">
	  <a href="#" class="pull-right">
	    <span class="glyphicon glyphicon-save"></span>
	  </a>
	  <small>СОХРАНИТЕ ДАННЫЕ</small>
	</div>
        <div class="panel-body">
	  <p><strong>Логин: #{session[:coordinator_credentials]['login']}</strong></p>
	  <p><strong>Пароль: #{session[:coordinator_credentials]['password']}</strong></p>
	</div>
      </div>
      COORDINATOR
      session.delete(:coordinator_credentials)
      coordinator.html_safe
    end
  end
end
