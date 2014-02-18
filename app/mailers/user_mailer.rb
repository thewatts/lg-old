class UserMailer < ActionMailer::Base
  default from: "lifegroups@newlifechurch.tv"

  def welcome_email(user)
    @user = user
    mail(
      :to => user.email,
      :subject => 'Welcome to LifeGroups!'
    )
  end
end
