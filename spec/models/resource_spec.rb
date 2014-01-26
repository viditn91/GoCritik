require 'spec_helper'

describe Resource do

  before(:all) do
    @resource = Resource.create(name: "foo", description: "bar")
    @user = User.create(email: "honey@singh.com", password: "yoyo!")
  end 

  describe 'validations' do
    describe 'presence' do
      context 'name' do
        it { should validate_presence_of(:name) }
      end
      context 'description' do
        it { should validate_presence_of(:description) }
      end
    end
    describe 'uniqueness' do
      context 'name' do
        it { should validate_uniqueness_of(:name).case_insensitive }
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
      context 'fields_values' do
        it { should have_many(:fields_values).dependent(:destroy) }
      end
      context 'reviews' do
        it { should have_many(:reviews).dependent(:destroy) }
      end
      context 'ratings' do
        it { should have_many(:ratings).dependent(:destroy) }
      end
    end
  end

  describe 'nested assignment' do
    context 'fields_values' do
      it { should accept_nested_attributes_for(:fields_values) }
    end
  end

  describe 'latest_review' do
    it do
      r1 = @resource.reviews.create(content: "yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo ", 
        user_id: @user.id, updated_at: 2.seconds.ago)
      r2 = @resource.reviews.create(content: "yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo ", 
        user_id: @user.id)
      r2.touch
      expect(@resource.latest_review).to eq(r2)
    end
  end

  after(:all) do
    @user.destroy
    @resource.destroy
  end

end