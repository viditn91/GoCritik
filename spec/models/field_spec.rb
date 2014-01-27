require 'spec_helper'

describe Field do
  let(:field) do
    Field.create(name: "Location",
     input_type: "String", type: "TextField",
     required: true, unique: false, searchable: true, sortable: false
    )
  end

  describe 'validations' do
    describe 'presence' do
      context 'name' do
        it { should validate_presence_of(:name) }
      end
    end
    describe 'uniqueness' do
      context 'name' do
        it { should validate_uniqueness_of(:name).case_insensitive }
      end
    end
    # describe 'exclusion' do
    # end
    describe 'inclusion' do
      context 'when input_type differs from the inclusion list' do
        it do
          field.update(input_type: 'some-wierd-value')
          expect(field.errors[:input_type].first).to eq('some-wierd-value is not a valid Input-Type')
        end
      end
      context 'when field_type differs from the inclusion list' do
        it do
          field.update(type: 'some-wierd-value')
          expect(field.errors[:type].first).to eq('some-wierd-value is not a valid Field-Type')
        end
      end
    end
    # describe 'boolean fields' do
    #   context 'when sortable is not true/false' do
    #     field.update(sortable: "non-boolean")
    #     expect(field.errors[:sortable].first).to eq('some-wierd-value is not a valid Field-Type')
    #   end
    # end
  end

  describe 'associations' do
    describe 'has_many' do
      context 'fields_values' do
        it { should have_many(:fields_values) }
      end
    end
  end

  describe 'serialize' do
    context 'options'do
      it { should serialize(:options) }
    end
  end

end