require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'test@example.com', password: 'password123') }

  subject do
    Recipe.new(user:, name: 'Pizza', preparation_time: 30, cooking_time: 15, description: 'Very easy to prepare',
               public: true)
  end

  before { subject.save }

  describe '#validators' do
    it 'requires name to be present' do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end

    it 'requires preparation_time to be a non-negative number' do
      subject.preparation_time = -5
      expect(subject).to_not be_valid
      expect(subject.errors[:preparation_time]).to include('must be greater than or equal to 0')
    end

    it 'requires cooking_time to be a non-negative number' do
      subject.cooking_time = -3
      expect(subject).to_not be_valid
      expect(subject.errors[:cooking_time]).to include('must be greater than or equal to 0')
    end

    it 'requires description to be present' do
      subject.description = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:description]).to include("can't be blank")
    end

    it 'requires description to have a maximum length of 250 characters' do
      subject.description = 'a' * 251
      expect(subject).to_not be_valid
      expect(subject.errors[:description]).to include('is too long (maximum is 250 characters)')
    end

    it 'requires public to be either true or false' do
      subject.public = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:public]).to include('is not included in the list')
    end
  end
end
