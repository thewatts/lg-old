class User < ActiveRecord::Base

  def self.from_omniauth(auth_hash)
    data = attributes_from(auth_hash)
    user = User.find_by(:provider => data[:provider], :uid => data[:uid])
    user ||= User.new(data)
    user.nickname = data[:nickname] if user.new_nickname?(data[:nickname])
    user.name = data[:name]         if user.new_name?(data[:name])
    user.image = data[:image]       if user.new_image?(data[:image])
    user.save
    user
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

  def update_auth_info_from(data)
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

  def new_email?(candidate)
    image != candidate
  end
end
