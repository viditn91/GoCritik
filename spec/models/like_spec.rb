require 'spec_helper'
  

describe Like do

  let(:resource) do
    Resource.create(name: "foo1".force_encoding("UTF-8"), description: "bar", state: true)
  end

  let(:user) do
    User.create(email: "honey@singh.com", password: "yoyo!")
  end

  let(:review) do
    Review.create(user_id: user.id, resource_id: resource.id, 
      content: "yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo yo"
    )
  end

  describe 'validations' do
    describe 'presence' do
      context 'user' do
        it { should validate_presence_of(:user_id) }
      end
      context 'likeable_type' do
        it { should validate_presence_of(:likeable_type) }
      end
      context 'likeable_id' do
        it { should validate_presence_of(:likeable_id) }
      end
    end
  end

  describe 'associations' do
    describe 'belongs_to' do
      context 'likeable' do
        before { @like = Like.create(user_id: user.id, likeable_type: 'Review', likeable_id: review.id) }
        it do
          expect(@like.likeable).to eq(review)
        end
      end
      context 'user' do
        it { should belong_to(:user) }
      end
    end
  end

  after(:all) do
    Review.delete_all
    Resource.delete_all
    Like.delete_all
    User.delete_all
  end
  
end