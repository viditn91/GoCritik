require 'spec_helper'

describe Review do
  let(:resource) do
    Resource.create(name: "foo1", description: "bar", state: true)
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
      context 'resource' do
        it { should validate_presence_of(:resource_id) }
      end
    end
    describe 'length' do
      context 'content' do
        it 'if content is less than 50 words' do
          review.update(content: "this content is less than 50 words")
          expect(review.errors.full_messages.first).to eq('Review content must have at least 50 words')
        end
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
    describe 'has_many' do
      context 'likes' do
        it { should have_many(:likes).dependent(:destroy) }
      end
      context 'comments' do
        it { should have_many(:comments).dependent(:destroy) }
      end
    end
  end

  describe 'latest_comment' do
    it do
      c1 = Comment.create(content: "hey there!", review_id: review.id, user_id: user.id, updated_at: 2.seconds.ago)
      c2 = Comment.create(content: "Its going to be legan -- wait-for-it -- dary!", user_id: user.id, review_id: review.id)
      expect(review.latest_comment).to eq(c2)
    end
  end

  after(:all) do
    Review.delete_all
    Resource.delete_all
    Comment.delete_all
    User.delete_all
  end
end