require 'spec_helper'

describe User do
  describe "using omniauth" do

    describe "with Facebook" do
      let(:uid)      { '12345' }
      let(:nickname) { 'jbloggs' }
      let(:email)    { 'joe@bloggs.com' }
      let(:name)     { 'Joe Bloggs' }
      let(:image)    { 'http://graph.facebook.com/1234567/picture?type=square' }
      let(:auth_hash) {
        {
          :provider => 'facebook',
          :uid      => uid,
          :info     => {
            :nickname   => nickname,
            :email      => email,
            :name       => name,
            :image      => image,
          }
        }
      }

      it "can be created" do
        expect{
          @user = User.from_omniauth(auth_hash)
        }.to change{User.count}.by 1
        expect(@user.provider).to eq 'facebook'
        expect(@user.nickname).to eq nickname
        expect(@user.name).to     eq name
        expect(@user.image).to    eq image
      end

      it "can be found" do
        user = User.from_omniauth(auth_hash)

        expect{
          @found_user = User.from_omniauth(auth_hash)
        }.to change{User.count}.by 0
        expect(@found_user).to eq user
      end

      it "will update new auth attributes" do
        user = User.from_omniauth(auth_hash)
        new_nickname = "my-new-nickname"
        expect(user.nickname).to eq nickname
        auth_hash[:info][:nickname] = new_nickname
        updated_user = User.from_omniauth(auth_hash)

        expect(updated_user.nickname).to eq new_nickname
      end
    end

    describe "with Twitter" do
      let(:uid)      { '12345' }
      let(:nickname) { 'jbloggs' }
      let(:name)     { 'Joe Bloggs' }
      let(:image)    { 'http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png' }
      let(:auth_hash) {
        {
          :provider => 'twitter',
          :uid      => uid,
          :info     => {
            :nickname   => nickname,
            :name       => name,
            :image      => image,
          }
        }
      }

      it "can be created" do
        expect{
          @user = User.from_omniauth(auth_hash)
        }.to change{User.count}.by 1
        expect(@user.provider).to eq 'twitter'
        expect(@user.nickname).to eq nickname
        expect(@user.name).to     eq name
        expect(@user.image).to    eq image
      end

      it "can be found" do
        user = User.from_omniauth(auth_hash)

        expect{
          @found_user = User.from_omniauth(auth_hash)
        }.to change{User.count}.by 0
        expect(@found_user).to eq user
      end

      it "will update new auth attributes" do
        user = User.from_omniauth(auth_hash)
        new_nickname = "my-new-nickname"
        expect(user.nickname).to eq nickname
        auth_hash[:info][:nickname] = new_nickname
        updated_user = User.from_omniauth(auth_hash)

        expect(updated_user.nickname).to eq new_nickname
      end
    end
  end
end
