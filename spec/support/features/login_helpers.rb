module Features
  module LoginHelpers

    def signup_user_with_facebook
      provider = 'facebook'
      uid = '12345'
      nickname = 'jbloggs'
      name = "Joe Bloggs"
      image = 'http://graph.facebook.com/1234567/picture?type=square'
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        :provider => provider,
        :uid      => uid,
        :info     => {
          :nickname   => nickname,
          :name       => name,
          :image      => image
        }
      })
      visit leader_signup_path
      click_on "Signup with Facebook"
      return User.new(
        :provider => provider,
        :uid => uid,
        :nickname => nickname,
        :name => name,
        :image => image
      )
    end

    def signup_user_with_twitter
      provider = 'twitter'
      uid = '12345'
      nickname = 'jbloggs'
      name = "Joe Bloggs"
      image = 'picture.png'
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        :provider => provider,
        :uid      => uid,
        :info     => {
          :nickname   => nickname,
          :name       => name,
          :image      => image
        }
      })
      visit leader_signup_path
      click_on "Signup with Twitter"
      return User.new(
        :provider => provider,
        :uid => uid,
        :nickname => nickname,
        :name => name,
        :image => image
      )
    end

  end
end
