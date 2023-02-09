require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'Validation testing' do
      context 'While creating user' do
        let(:user1) {build :user}
        let(:user2) {build :user,email: "email"}
        let(:user3) {build :user,phone: -1}

        it 'should be valid user with all attributes' do
          expect(user1.valid?).to eq(true)
        end
        
        it 'should not be valid user without valid email  ' do
          expect(user2.valid?).to eq(false)
        end

        it 'should not be valid seller without valid phone number  ' do
          expect(user3.valid?).to eq(false)
        end

      end
    end
end
