# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(first_name: 'lorem',
                        last_name: 'ipsum',
                        email: 'test@email.com',
                        password: 'pw1234',
                        password_confirmation: 'pw1234')
  end
  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a first_name' do
      subject.first_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("First name can't be blank")
    end
    it 'is not valid without a last_name' do
      subject.last_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Last name can't be blank")
    end
    it 'is not valid without a email' do
      subject.email = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Email can't be blank")
    end
    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Password can't be blank")
    end
    it 'is not valid without a password_confirmation' do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Password confirmation can't be blank")
    end
    it 'is not valid if the password and password_confirmation do not match' do
      subject.password_confirmation = 'not_match_password'
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'is not valid if the email is not unique(not case sensitive)' do
      subject.save
      new_user = described_class.create(first_name: 'new_lorem',
                                        last_name: 'new_ipsum',
                                        email: 'TEST@email.com',
                                        password: 'pw1234',
                                        password_confirmation: 'pw1234')
      expect(new_user).to_not be_valid
    end
    it 'is not valid if the password is shorter than 6 characters' do
      subject.password = 'short'
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'should return an instance of the user if successfully authenticated' do
      subject.save
      @user = described_class.authenticate_with_credentials('test@email.com', 'pw1234')
      expect(@user).to be_an_instance_of(described_class)
    end
    it 'should return nil if not successfully authenticated' do
      @user = described_class.authenticate_with_credentials('not_match@email.com', 'pw1234')
      expect(@user).to be_nil
    end
    it 'should successfully authenticated if there are a few spaces before and/or after their email address' do
      subject.save
      @user = described_class.authenticate_with_credentials('  test@email.com  ', 'pw1234')
      expect(@user).to be_an_instance_of(described_class)
    end
    it 'should successfully authenticatedif there are wrong cases for their email' do
      subject.save
      @user = described_class.authenticate_with_credentials('TEST@email.com', 'pw1234')
      expect(@user).to be_an_instance_of(described_class)
    end
  end
end
