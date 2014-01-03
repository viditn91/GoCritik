namespace :db do
  namespace :setup do
    desc "create default admin user"
    task :admin => :environment do
      admin = User.create(
        :email => "vidit@vinsol.com", 
        :password => "vidit", 
        :password_confirmation => "vidit",
        :first_name => "vidit",
        :last_name => "jain",
        :admin => true
        )
      admin.save
    end
  end
end