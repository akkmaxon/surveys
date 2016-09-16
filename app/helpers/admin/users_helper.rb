module Admin::UsersHelper
  def render_user
    if session.key?(:user_credentials)
      user = <<-USER
      <div class="panel panel-default" id="user_credentials">
        <div class="panel-heading text-center">
	  <h2 class="h4">Респондент <i>#{session[:user_credentials]['login']}</i></h2>
	</div>
        <div class="panel-body">
	  <p><strong>Логин: #{session[:user_credentials]['login']}</strong></p>
	  <p><strong>Пароль: #{session[:user_credentials]['password']}</strong></p>
	  <button class="btn btn-primary btn-block" id="save_user">
	    <span class="glyphicon glyphicon-save"></span>
	    СОХРАНИТЬ
	  </button>
	</div>
      </div>
      USER
      session.delete(:user_credentials)
      user.html_safe
    end
  end
end
