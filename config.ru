$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/lib')

use Rack::ShowExceptions

require 'lib/git_http'

config = {
  :project_root          => "/srv/git",
  :git_path              => '/usr/local/libexec/git-core/git',
  :upload_pack           => true,
  :receive_pack          => true,

  :use_redmine_auth      => true,
  :require_ssl_for_auth  => true,
  :redmine_db_type       => "Mysql",
  :redmine_db_host       => "localhost",
  :redmine_db_name       => "miner_rm",
  :redmine_db_user       => "miner_rm",
  :redmine_db_pass       => "password",

}


$grackConfig = config
if defined?(config[:use_redmine_auth])
	if(config[:use_redmine_auth])
		require 'lib/redmine_grack_auth'
		use RedmineGrackAuth do |user,pass|
			false #dummy code, validation is done in module
		end
	end
end


run GitHttp::App.new(config)
