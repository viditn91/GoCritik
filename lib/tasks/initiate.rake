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
    desc "load liquid templates"
    task :templates => :environment do
      template_array = [
        {
          content: '<h4> <i class="icon-map-marker"> {% for field_value in resource.fields_values %} {% if field_value.field.name == "Location" %} {{ field_value.value }}, {% elsif field_value.field.name == "City" %} {{ field_value.value }} {% endif %} {% endfor %} </i> </h4>',
          controller: 'resources', 
          action: 'show', 
          view_element: 'keywords'
        },
        {
          content: '<ul class="inline"> {% for field_value in resource.fields_values %} {% if field_value.field.name != "Location" and field_value.field.name != "City" %} <li class="side-buffer"> <i class="icon-tag"></i> {{ field_value.field.name }}: {{ resource.id | get_value_from_field: field_value.field.id }} </li> {% endif %} {% endfor %} </ul>', 
          controller: 'resources', 
          action: 'show', 
          view_element: 'tags'
        },
        {
          content: '<div> <i class="icon-map-marker"> {% for field_value in resource.fields_values %} {% if field_value.field.name == "Location" %} {{ field_value.value }}, {% elsif field_value.field.name == "City" %} {{ field_value.value }} {% endif %} {% endfor %} </i> </div>', 
          controller: 'resources', 
          action: 'index', 
          view_element: 'keywords'
        },
        {
          content: '<div> <i class="icon-map-marker"> {% for field_value in resource.fields_values %} {% if field_value.field.name == "Location" %} {{ field_value.value }}, {% elsif field_value.field.name == "City" %} {{ field_value.value }} {% endif %} {% endfor %} </i> </div>', 
          controller: 'users', 
          action: 'show', 
          view_element: 'review keywords'
        },
        {
          content: '<div> <i class="icon-map-marker"> {% for field_value in resource.fields_values %} {% if field_value.field.name == "Location" %} {{ field_value.value }}, {% elsif field_value.field.name == "City" %} {{ field_value.value }} {% endif %} {% endfor %} </i> </div>', 
          controller: 'users', 
          action: 'show', 
          view_element: 'rating keywords'
        },
        {
          content: '<div> <i class="icon-map-marker"> {% for field_value in resource.fields_values %} {% if field_value.field.name == "Location" %} {{ field_value.value }}, {% elsif field_value.field.name == "City" %} {{ field_value.value }} {% endif %} {% endfor %} </i> </div>', 
          controller: 'users', 
          action: 'show', 
          view_element: 'resource keywords'
        },
        {
          content: '<div> <i class="icon-map-marker"> {% for field_value in resource.fields_values %} {% if field_value.field.name == "Location" %} {{ field_value.value }}, {% elsif field_value.field.name == "City" %} {{ field_value.value }} {% endif %} {% endfor %} </i> </div>', 
          controller: 'reviews', 
          action: 'show', 
          view_element: 'resource keywords'
        }
      ]
      template_array.each do |attr_hash|
        Template.create attr_hash
      end
    end
  end
end