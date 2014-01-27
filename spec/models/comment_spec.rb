require 'spec_helper'

describe Comment do
  
  describe 'validations' do
    describe 'presence' do
      context 'review' do
        it { should validate_presence_of(:review_id) }
      end
      context 'user' do
        it { should validate_presence_of(:user_id) }
      end
      context 'content' do
        it { should validate_presence_of(:content) }
      end
    end
  end

  describe 'associations' do
    describe 'belongs_to' do
      context 'review' do
        it { should belong_to(:review) }
      end
      context 'user' do
        it { should belong_to(:user) }
      end
    end
    describe 'has_many' do
      context 'likes' do
        it { should have_many(:likes).dependent(:destroy) }
      end
    end
  end

end
