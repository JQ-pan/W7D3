# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  session_token   :string           not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }

  it { should validate_length_of(:password).is_at_least(6)}
  
  it { should have_many(:goals) }

  it { should validate_uniqueness_of(:username) }


  describe 'uniqueness' do
    before :each do
      create(:user)
    end

    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
  end

  # describe "is_password?" do
  #   let!(:user) {create(:user)}

  #   context "with a valid password" do 
  #     it "should return true" do
  #       expect(user.is_password?("password")).to be true
  #     end
  #   end

  #   context
end
