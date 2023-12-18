require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John Doe', photo: 'https://jhon-doe-picture', email: 'john@doe.com', password: 'johndoe123') }

  before { subject.save }

  describe '#validators' do
    it 'Name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should have the role user by default' do
      expect(subject.role).to eq('user')
    end

    it 'should have an email' do
      expect(subject.email).to eq('john@doe.com')
    end
  end
end
