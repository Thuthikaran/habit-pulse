class SessionsController < Devise::SessionsController
    def guest_login
      guest = User.find_or_create_by!(email: 'guest@example.com') do |user|
        user.password = SecureRandom.hex
        user.guest = true
      end
  
      sign_in(guest)
      redirect_to root_path, notice: 'You are now logged in as a guest.'
    end
  end
  