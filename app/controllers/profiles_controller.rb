class ProfilesController < ApplicationController
    
    # GET to /users/:users_id/profile/new
    def new
        # Render blank profile details form
        @profile = Profile.new
    end
    
    # POST to /users/:users_id/profile
    def create
        # Ensure that we have the user that is filling out the form
        @user = User.find( params[:user_id] )
        # Create a profile linked to this user
        @profile = @user.build_profile(profile_params)
        if @profile.save
            flash[:success] = "Your profile has been successfully updated!"
            redirect_to user_path( params[:user_id] )
        else
            render action: :new
        end
    end
    
    private
        def profile_params
            params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description, :avatar)
        end
end