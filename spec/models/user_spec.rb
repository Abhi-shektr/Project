require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'Validation testing' do
      
      context 'While creating user' do
        let(:user1) {build :user}
        let(:user2) {build :user,email: "email"}
        let(:user3) {build :user,phone: -1}
        let(:user4) {build :user,phone: 1234}
        let(:user5) {build :user,phone: "abscd1"}

        it 'should be valid user with all attributes' do
          expect(user1.valid?).to eq(true)
        end
        
        it 'should not be valid user, without valid email' do
          expect(user2.valid?).to eq(false)
        end

        it 'should not be valid user, without valid phone number(cannot be negative)  ' do
          expect(user3.valid?).to eq(false)
        end

        it 'should not be valid user, without valid phone number(minimum 10 digits)  ' do
          expect(user4.valid?).to eq(false)
        end

        it 'should not be valid user, without valid phone number(only numbers)  ' do
          expect(user5.valid?).to eq(false)
        end

      end
    end
end
