require 'spec_helper'

describe User do

  describe "validations" do
    it "is valid with valid attributes" do
      expect(build(:user)).to be_valid
    end

    it "has a name" do
      blank_name = build(:user, :name => "")
      expect(blank_name).not_to be_valid
      expect(blank_name.errors.messages[:name]).not_to be_nil
    end

    it "has an email after initial creation" do
      blank_email = create(:user, :email => "")
      expect(blank_email).not_to be_valid
      expect(blank_email.errors.messages[:email]).not_to be_nil
    end

    it "has a unique email" do
      create(:user, :email => "unique@example.com")
      duplicate = build(:user, :email => "unique@example.com")

      expect(duplicate).not_to be_valid
      expect(duplicate.errors.messages[:email]).not_to be_nil
    end

    it "has a lowercased email" do
      email = "EMAIL@Example.com"
      user = build(:user, :email => email)
      user.save
      expect(user.email).to eq email.downcase
    end

    it "email is an email" do
      invalid_email = create(:user, :email => "asdf1234")

      expect(invalid_email).not_to be_valid
      expect(invalid_email.errors.messages[:email]).not_to be_nil
    end

    it "has a unique nickname" do
      create(:user, :nickname => "nickname")
      duplicate = build(:user, :nickname => "nickname")

      expect(duplicate).not_to be_valid
      expect(duplicate.errors.messages[:nickname]).not_to be_nil
    end

    it "has a nickname from the display name" do
      user = build(:user, :display_name => "Nathaniel Watts", :nickname => nil)
      user.save
      expect(user.nickname).to eq("nathaniel.watts")
    end

    it "auto increments a nickname if it's already taken" do
      user = build(:user, :display_name => "John Smith", :nickname => nil)
      user2 = build(:user, :display_name => "John Smith", :nickname => nil)
      user3 = build(:user, :display_name => "John Smith", :nickname => nil)
      user.save
      user2.save
      user3.save
      expect(user.nickname).to eq "john.smith"
      expect(user2.nickname).to eq"john.smith-2"
      expect(user3.nickname).to eq"john.smith-3"
    end

    it "has a display name after update" do
      user = create(:user, :display_name => nil)
      user.save
      expect(user).not_to be_valid
    end

  end

  describe "using omniauth" do

    describe "with Facebook" do
      let(:uid)      { '12345' }
      let(:email)    { 'joe@bloggs.com' }
      let(:name)     { 'Joe Bloggs' }
      let(:image)    { 'picture.png' }
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
