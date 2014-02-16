require 'spec_helper'

describe User do
  describe "using omniauth" do
    it "can be created via Facebook" do
      uid       = '12345'
      nickname  = 'jbloggs'
      email     = 'joe@bloggs.com'
      name      = 'Joe Bloggs'
      image     = 'http://graph.facebook.com/1234567/picture?type = square'
      auth_hash = {
        :provider => 'facebook',
        :uid      => uid,
        :info     => {
          :nickname   => nickname,
          :email      => email,
          :name       => name,
          :first_name => 'Joe',
          :last_name  => 'Bloggs',
          :image      => image,
        }
      }
      expect{
        @user = User.from_omniauth(auth_hash)
      }.to change{User.count}.by 1
      expect(@user.provider).to eq 'facebook'
      expect(@user.nickname).to eq nickname
      expect(@user.email).to    eq email
      expect(@user.name).to     eq name
      expect(@user.image).to    eq image
    end
  end
end
