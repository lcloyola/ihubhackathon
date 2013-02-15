class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model
    @user = User.find_or_create_from_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in @user
      # @ticket = Ticket.find_by_ticket_number session[:ticket_number].to_i
      # if @ticket
      #   @ticket.user = @user
      #   @ticket.save
      #   redirect_to rsvp_path(session[:ticket_number], session[:response])
      # else
      #   redirect_to root_url
      # end
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      flash[:alert] = "Log in to FB failed, please try again"
    end
    redirect_to root_url
  end
end

