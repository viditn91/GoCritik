namespace :db do
  namespace :setup do
    desc "create default admin user"
    task :admin => :environment do
      begin
        puts "Enter email:"
        email = STDIN.gets.chomp
        puts "Enter password:"
        password = STDIN.gets.chomp
        puts "Confirm password:"
        password_confirmation = STDIN.gets.chomp
        admin = User.create(
          :email => email, 
          :password => password, 
          :password_confirmation => password_confirmation,
          :admin => true
          )
        if admin.save
          puts "Admin created successfully"
          exit
        else
          if password != password_confirmation
            puts "Password confirmation mismatch"
          else
            puts "Email format not correct"
          end
        end
      end while 1
    end
    task :templates => :environment do
    end
  end
end