module DbActions
  def self.backup
    conf = ActiveRecord::Base.connection_config
    `PGPASSWORD=#{conf[:password]} pg_dump --username #{conf[:username]}\
 --clean --format=c --no-owner --no-acl #{conf[:database]}`
  end

  def self.restore(file)
    conf = ActiveRecord::Base.connection_config
    `PGPASSWORD=#{conf[:password]} pg_restore --username #{conf[:username]}\
 --clean --schema public --no-owner --no-acl --dbname #{conf[:database]} #{file}`
  end
end
