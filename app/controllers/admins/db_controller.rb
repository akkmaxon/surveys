class Admins::DbController < Admins::ApplicationController
  def backup
    send_data DbActions.backup, filename: "Опросы_#{Time.now.strftime('%d.%m.%Y')}.pg_backup"
  end
end
