require 'spec_helper'

describe User do
  
  let(:user) do
    User.create(email: 'honey2@singh.com', password: 'yoyo!')
  end
  
  describe 'validations' do
    describe 'presence' do
      context 'email' do
        it { should validate_presence_of(:email) }
      end
      context 'password' do
        it { should validate_presence_of(:password) }
      end
      context 'first_name' do
        it { should validate_presence_of(:first_name) }
      end
      context 'last_name' do
        it { should validate_presence_of(:last_name) }
      end
    end
    describe 'uniqueness' do
      context 'email' do
        it { should validate_uniqueness_of(:email).case_insensitive }
      end
    end
  end

  describe 'associations' do
    describe 'has_one' do
      context 'picture' do
        it { should have_one(:picture).dependent(:destroy) }
      end
    end
    describe 'has_many' do
      context 'reviews' do
        it { should have_many(:reviews).dependent(:destroy) }
      end
      context 'ratings' do
        it { should have_many(:ratings).dependent(:destroy) }
      end
      context 'likes' do
        it { should have_many(:likes).dependent(:destroy) }
      end
    end
  end

  # describe 'has_profile_picture?' do
  #   context 'when picture is uploaded' do
  #     it do
  #       user.picture.photo = File.new(Rails.root + 'spec/fixtures/images/rails.jpg')
  #       expect(user.picture.photo.to_s).not_to eq('/images/default/original/missing.jpg')
  #     end
  #   end
  #   context 'when picture is not uploaded' do
  #     it do
  #       user.picture.photo = nil
  #       expect(user.picture.photo.to_s).to eq('/images/default/original/missing.jpg')
  #     end
  #   end
  # end

  describe 'full_name' do
    context 'when first and last name are not set by user' do
      it do
        expect(user.full_name).to eq('Gocritik Member')
      end
    end
    context 'when first and last name are set by user' do
      it do
        user.first_name = 'john'
        user.last_name = 'carter'
        expect(user.full_name).to eq('John Carter')
      end
    end
  end

  after(:all) do
    User.delete_all
    Picture.delete_all
  end

end