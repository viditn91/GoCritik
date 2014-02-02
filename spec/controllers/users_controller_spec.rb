require 'spec_helper'

describe UsersController do

  let(:valid_attributes) {{ email: "someone@vinsol.com", password: "secret" }}
  let(:update_attributes) {{ first_name: "someone_else" }}
  let(:user) { User.create! valid_attributes }
  let(:invalid_update_attributes) {{ first_name: "" }}

  describe "GET #show" do
    describe "if user found" do
      it "loads the user into @user" do
        get :show, { :id => user.id }
        expect(assigns(:user)).to eq(user)
      end

      it "loads the liquid template for reviews into @review_keywords_template" do
        get :show, { :id => user.id }
        expect(assigns(:review_keywords_template)).to eq(Template.find_by(controller: 'users', action: 'show', view_element: 'review keywords'))
      end

      it "loads the liquid template for ratings into @rating_keywords_template" do
        get :show, { :id => user.id }
        expect(assigns(:rating_keywords_template)).to eq(Template.find_by(controller: 'users', action: 'show', view_element: 'rating keywords'))
      end
    end
    
    describe "if user not found" do
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

  describe "GET #edit" do
    describe "if user found" do
      it "loads the user into @user" do
        get :edit, { :id => user.id }
        expect(assigns(:user)).to eq(user)
      end
      describe "if current_user is same as @user" do
        it "renders the edit template" do
          sign_in user
          get :edit, { :id => user.id }
          response.should render_template("edit")
        end
      end
      describe "if current_user is not @user" do
        it "redirects to the user page" do
          other_user = User.create!(email: "someone_else@vinsol.com", password: "secret")
          sign_in other_user
          get :edit, { :id => user.id }
          response.should redirect_to user_path(user) 
        end
      end

    end

    describe "if user not found" do
      describe "if http referer exists" do
        it "redirects to the referer" do
          request.env['HTTP_REFERER'] = admin_path
          get :edit, { :id => 'something-wierd' }
          response.should redirect_to(admin_path)
        end
      end
      
      describe "if http referer does not exist" do
        it "redirects to the resources_path" do
          request.env['HTTP_REFERER'] = nil
          get :edit, { :id => 'something-wierd' }
          response.should redirect_to(resources_path)
        end
      end
    end
  end

  describe "PUT #update" do
    describe "if user found" do
      it "loads the user into @user" do
        put :update, { :id => user.id , user: update_attributes }
        expect(assigns(:user)).to eq(user)
      end

      describe "if valid update_attributes" do
        it "update the user profile with new info" do
          put :update, { :id => user.id , user: update_attributes }
          user.reload
          expect(user.first_name).to eq('someone_else')
        end
      end
      describe "if invalid update_attributes" do
        it "re-renders the 'edit' template" do
          put :update, { :id => user.id , user: invalid_update_attributes }
          response.should render_template("edit")
        end
      end
    end

    describe "if user not found" do
      describe "if http referer exists" do
        it "redirects to the referer" do
          request.env['HTTP_REFERER'] = admin_path
          put :update, { :id => 'something-wierd' , user: update_attributes }
          response.should redirect_to(admin_path)
        end
      end
      
      describe "if http referer does not exist" do
        it "redirects to the resources_path" do
          request.env['HTTP_REFERER'] = nil
          put :update, { :id => 'something-wierd' , user: update_attributes }
          response.should redirect_to(resources_path)
        end
      end
    end
  end
end