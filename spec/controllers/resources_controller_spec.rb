require 'spec_helper'

describe ResourcesController do

  let(:valid_attributes) {{ email: "someone@vinsol.com", password: "secret" }}
  let(:user) { User.create! valid_attributes }
  let(:resource) { Resource.create!(name: "some resource", description: "some description", state: true) }
  let(:all_fields) { Field.all }

  describe "GET #new" do
    describe "if user logged in" do
      it "loads all fields into @fields" do
        sign_in user
        get :new, { }
        expect(assigns(:fields)).to eq(all_fields)
      end

      it "renders the new template" do
        sign_in user
        get :new, { }
        response.should render_template("new")
      end
    end

    # describe "if user not logged in" do
    #   it "redirects to the login page" do
    #     get :new, { }
    #     response.should redirect_to(new_user_session_path)
    #   end
    # end
  end

  describe "POST #create" do
    describe "if user logged in" do
      it "loads all fields into @fields" do
        sign_in user
        post :create, resource: { name: "some other resource", description: "some other description" }
        expect(assigns(:fields)).to eq(all_fields)
      end

      it "redirects to resources path if valid resource attributes" do
        sign_in user
        post :create, resource: { name: "some other resource", description: "some other description" }
        response.should redirect_to(resources_path)
      end

      it "renders the new template, if resource attributes are invalid" do
        sign_in user
        post :create, resource: { name: "", description: "" }
        response.should render_template("new")
      end
    end

    # describe "if user not logged in" do
    #   it "redirects to the login page" do
    #     get :new, { }
    #     response.should redirect_to(new_user_session_path)
    #   end
    # end

  end

  describe "GET #index" do
    it "loads all fields into @fields" do
      get :index, { }
      expect(assigns(:fields)).to eq(all_fields)
    end

    it "loads the liquid template for keywords into @keywords_template" do
      get :show, { :id => resource.permalink }
      expect(assigns(:keywords_template)).to eq(Template.find_by(controller: 'resources', action: 'index', view_element: 'keywords'))
    end

    it "loads all resources into @resources when no search parameter is sent" do
      get :index, {}
      expect(assigns(:resources)).to eq(Resource.approved)
    end

    # it "loads all resources matching the search parameter into @resources" do
    #   get :index, { :search => "some resource" }
    #   expect(assigns(:resources)).to eq([resource])
    # end

  end

  describe "GET #show" do
    describe "if resource found" do
      it "loads the resource into @resource" do
        get :show, { :id => resource.permalink }
        expect(assigns(:resource)).to eq(resource)
      end

      it "loads the liquid template for keywords into @keywords_template" do
        get :show, { :id => resource.permalink }
        expect(assigns(:keywords_template)).to eq(Template.find_by(controller: 'resources', action: 'show', view_element: 'keywords'))
      end

      it "loads the liquid template for ratings into @tags_template" do
        get :show, { :id => resource.permalink }
        expect(assigns(:tags_template)).to eq(Template.find_by(controller: 'resources', action: 'show', view_element: 'tags'))
      end

      it "renders the new template" do
        get :show, { :id => resource.permalink }
        response.should render_template("show")
      end
    end

    describe "if resource not found" do
      describe "if http referer exists" do
        it "redirects to the referer" do
          request.env['HTTP_REFERER'] = admin_path
          get :show, { :id => 'something-wierd' }
          response.should redirect_to(admin_path)
        end
      end
      
      describe "if http referer does not exist" do
        it "redirects to the resources_path" do
          request.env['HTTP_REFERER'] = nil
          get :show, { :id => 'something-wierd' }
          response.should redirect_to(resources_path)
        end
      end
    end
  end
end
