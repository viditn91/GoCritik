require 'spec_helper'

describe Picture do
  let(:user) do
    User.create(email: "honey@singh.com", password: "yoyo!")
  end

  describe 'associations' do
    describe 'belongs_to' do
      context 'imageable' do
        before { @picture = Picture.create(imageable_type: 'User', imageable_id: user.id) }
        it do
          expect(@picture.imageable).to eq(user)
        end
      end
    end
  end

end
