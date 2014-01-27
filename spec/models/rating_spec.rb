require 'spec_helper'

describe Rating do

  let(:resource) do
    Resource.create(name: "foo1", description: "bar", state: true)
  end
  
  let(:user) do
    User.create(email: "honey@singh.com", password: "yoyo!")
  end
  
  describe 'validations' do
    describe 'presence' do
      context 'value' do
        it { should validate_presence_of(:value) }
      end
      context 'user' do
        it { should validate_presence_of(:user_id) }
      end
      context 'resource' do
        it { should validate_presence_of(:resource_id) }
      end
    end
    describe 'uniqueness' do
      context 'user' do
        before { Rating.create(value: "2", resource_id: resource.id, user_id: user.id)}
        it { should validate_uniqueness_of(:user_id).scoped_to(:resource_id) }
      end
    end
  end

  describe 'associations' do
    describe 'belongs_to' do
      context 'resource' do
        it { should belong_to(:resource) }
      end
      context 'user' do
        it { should belong_to(:user) }
      end
    end
  end

  after(:all) do
    Rating.delete_all
    Resource.delete_all
    User.delete_all
  end

end
