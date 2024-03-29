class User < ActiveRecord::Base

  has_many :lifegroups, :through => :group_leaders
  has_many :group_leaders

  validates :display_name, :presence => true, :on => :update
  validates :email, :presence => true, :format => {
    :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,}\z/
  }, :on => :update
  validates :email, :uniqueness => true
  validates :name,  :presence => true
  validates :nickname, :uniqueness => true


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
      :name     => auth_hash[:info][:name],
      :image    => auth_hash[:info][:image],
    }
  end

  def save(options = {})
    self.email    = email.to_s.downcase unless email.nil?
    self.nickname = nickname_from(display_name) if nickname.nil?
    super(options)
  end

  def update(params)
    if new_display_name?(params[:display_name])
      params.merge!(:nickname => nickname_from(params[:display_name]))
    end
    super
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def complete?
    email? && display_name?
  end

  def new_auth_attributes?(data)
    new_name?(data[:name]) || new_image?(data[:image])
  end

  def logged_in_message
    "Congrats, #{display_name}, You've successfully logged in!"
  end

  def finalized_signup_message
    "You're officially signed up, #{display_name}!"
  end

  def initial_signup_message
    "Thanks for signing up, #{name}!"
  end

private

  def new_name?(candidate)
    name != candidate
  end

  def new_image?(candidate)
    image != candidate
  end

  def new_display_name?(candidate)
    display_name != candidate
  end

  def nickname_from(display_name)
    return "" if display_name.nil?
    generate_valid_nickname_from(display_name)
  end

  def generate_valid_nickname_from(display_name)
    candidate = to_nickname(display_name)
    count = 2
    while User.find_by(:nickname => candidate)
      candidate = "#{to_nickname(display_name)}-#{count}"
      count += 1
    end
    candidate
  end

  def to_nickname(name)
    name.to_s.parameterize.gsub('-', '.')
  end
end
