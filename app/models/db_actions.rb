module DbActions
  def self.backup
    conf = ActiveRecord::Base.connection_config
    `PGPASSWORD=#{conf[:password]} pg_dump --username #{conf[:username]}\
 --clean --format=c --no-owner --no-acl #{conf[:database]}`
  end
end
