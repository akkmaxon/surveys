namespace :db do
  FILE = "#{Rails.root}/db/surveys.backup"

  DB_CONFIG = YAML.load(
    File.open("#{Rails.root}/config/database.yml")
  )[Rails.env]

  def moving_points
    3.times { print "."; sleep 1 }
  end

  desc 'Create a db/surveys.backup file'
  task :backup do
    print "Create backup for surveys_#{Rails.env}. Ctrl^C to cancel "
    moving_points
    `PGPASSWORD=#{DB_CONFIG["password"]} pg_dump\
 --username #{DB_CONFIG["username"]}\
 --clean --format=c --no-owner --no-acl\
 #{DB_CONFIG["database"]} > #{FILE}`
    puts " Ready.\nYour backup file is #{FILE}."
  end

  desc 'Restore db from a db/surveys.backup'
  task :restore do
    if File.exists?(FILE)
      print "Restore surveys_#{Rails.env}. Ctrl^C to cancel "
      moving_points
      `PGPASSWORD=#{DB_CONFIG["password"]} pg_restore\
   --username #{DB_CONFIG["username"]}\
   --clean --schema public --no-owner --no-acl\
   --dbname #{DB_CONFIG["database"]} #{FILE}`
      puts " Ready."
    else
      puts "Your backup file is absent. Make sure that file\n#{FILE}\nexists"
    end
  end
end
