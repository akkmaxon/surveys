module Admin::CoordinatorsHelper
  def render_coordinator
    if session.key?(:coordinator_credentials)
      coordinator = <<-COORDINATOR
      <div class="panel panel-default" id="coordinator_credentials">
        <div class="panel-heading text-center">
	  <h2 class="h4">Координатор <i>#{session[:coordinator_credentials]['login']}</i></h2>
	</div>
        <div class="panel-body">
	  <p><strong>Логин: #{session[:coordinator_credentials]['login']}</strong></p>
	  <p><strong>Пароль: #{session[:coordinator_credentials]['password']}</strong></p>
	  <button class="btn btn-primary btn-block" id="save_coordinator">
	    <span class="glyphicon glyphicon-save"></span>
	    СОХРАНИТЬ
	  </button>
	</div>
      </div>
      COORDINATOR
      session.delete(:coordinator_credentials)
      coordinator.html_safe
    end
  end
end
