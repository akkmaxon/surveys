module Admin::ApplicationHelper
  def render_person(session_key)
    if session.key?(session_key)
      person = <<-PERSON
      <div class="panel panel-default" id="#{session_key}">
        <div class="panel-body">
	  <div class="pull-right glyphicon glyphicon-info-sign" title="Обязательно сохраните данные, в дальнейшем они будут недоступны для просмотра!"></div>
	  <p><strong>Логин: #{session[session_key]['login']}</strong></p>
	  <p><strong>Пароль: #{session[session_key]['password']}</strong></p>
	  <button class="btn btn-primary btn-block" id="save_person">
	    <span class="glyphicon glyphicon-save"></span>
	    СОХРАНИТЬ
	  </button>
	</div>
      </div>
      PERSON
      session.delete(session_key)
      person.html_safe
    end
  end
end
