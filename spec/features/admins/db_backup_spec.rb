require 'rails_helper'

RSpec.describe 'Admin can download backup file' do
  let(:admin) { FactoryGirl.create :admin }

  describe 'unreachable for non-admins' do
    after do
      expect(page.current_path).to eq new_admin_session_path
      within '#messages .alert-danger' do
	expect(page).to have_content "Войдите, пожалуйста, в систему"
      end
    end

    it 'unsigned in user' do
      visit admins_db_backup_path
    end

    it 'signed in user' do
      sign_in FactoryGirl.create(:user)
      visit admins_db_backup_path
    end

    it 'signed in coordinator' do
      sign_in FactoryGirl.create(:coordinator)
      visit admins_db_backup_path
    end
  end

  it 'successfully' do
    sign_in admin
    visit admins_root_path
    find('#db_backup_link').trigger('click')
    sleep 2
    expect(page.response_headers["Content-Type"]).
      to eq("application/octet-stream")
    expect(page.response_headers["Content-Transfer-Encoding"]).
      to eq("binary")
    expect(page.response_headers["Content-Disposition"]).
      to eq("attachment; filename=\"Опросы_#{Time.now.strftime('%d.%m.%Y')}.pg_backup\"")
  end
end
