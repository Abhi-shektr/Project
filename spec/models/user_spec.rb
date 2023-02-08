require 'rails_helper'

RSpec.describe User, type: :model do
    context 'While creating user' do
      let(:user1) {build :user}
      let(:user2) {build :user,email: "email"}

      it 'should be valid user with all attributes' do
        expect(user1.valid?).to eq(true)
      end
      
      it 'should not be valid user without valid email  ' do
        expect(user2.valid?).to eq(false)
      end
    end
end
