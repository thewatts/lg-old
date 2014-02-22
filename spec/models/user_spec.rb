require 'spec_helper'

describe User do
  describe "using omniauth" do

    describe "with Facebook" do
      let(:uid)      { '12345' }
      let(:email)    { 'joe@bloggs.com' }
      let(:name)     { 'Joe Bloggs' }
      let(:image)    { 'http://graph.facebook.com/1234567/picture?type=square' }
      let(:auth_hash) {
        {
          :provider => 'facebook',
          :uid      => uid,
          :info     => {
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
        new_image = "my-new-image.png"
        expect(user.image).to eq image
        auth_hash[:info][:image] = new_image
        updated_user = User.from_omniauth(auth_hash)

        expect(updated_user.image).to eq new_image
      end
    end

    describe "with Twitter" do
      let(:uid)      { '12345' }
      let(:name)     { 'Joe Bloggs' }
      let(:image)    { 'http://avatar.png' }
      let(:auth_hash) {
        {
          :provider => 'twitter',
          :uid      => uid,
          :info     => {
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
        new_image = "my-new-image.png"
        expect(user.image).to eq image
        auth_hash[:info][:image] = new_image
        updated_user = User.from_omniauth(auth_hash)

        expect(updated_user.image).to eq new_image
      end
    end
  end
end
