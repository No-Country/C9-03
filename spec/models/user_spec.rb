require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build :user }

  it 'is valid with required attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without email' do
    user.email = nil
    expect(user).to_not be_valid
  end

  it 'is not valid without name' do
    user.name = nil
    expect(user).to_not be_valid
  end

  context 'is not valid if the email is already registered' do
    let(:old_user) { create :user }
    let(:new_user) { build :user, email: old_user.email }

    it 'should return email already registered' do
      expect(new_user).to be_invalid
    end
  end

  it 'is not valid without a password' do
    user.password = nil
    expect(user).to_not be_valid
  end

  it 'is not valid if password and password_confirmation are not the same' do
    user.password = 'ABC'
    expect(user).to_not be_valid
  end
end
