class User < ActiveRecord::Base

  def self.from_omniauth(auth_hash)
    data = attributes_from(auth_hash)
    if user = User.find_by(:provider => data[:provider], :uid => data[:uid])
      user.update_attributes(data) if user.new_auth_attributes?(data)
      user
    else
      create(data)
    end
  end

  def self.attributes_from(auth_hash)
    {
      :uid      => auth_hash[:uid],
      :provider => auth_hash[:provider],
      :nickname => auth_hash[:info][:nickname],
      :name     => auth_hash[:info][:name],
      :email    => auth_hash[:info][:email],
      :image    => auth_hash[:info][:image],
    }
  end

  def new_auth_attributes?(data)
    new_nickname?(data[:nickname]) ||
    new_name?(data[:name])         ||
    new_image?(data[:image])
  end

  def new_nickname?(candidate)
    nickname != candidate
  end

  def new_name?(candidate)
    name != candidate
  end

  def new_image?(candidate)
    image != candidate
  end
end
