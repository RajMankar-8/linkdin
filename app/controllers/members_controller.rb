class MembersController < AuthenticateController
  
  def show
    @user = User.find(params[:id])
    @connections = Connection.where('user_id = ? OR connected_user_id = ?', params[:id], params[:id])
                   .where(status: "accepted")
    @mutual_connections = current_user.mutually_connected_ids(@user)
  end

  def edit_description; end 

  def update_description
    if current_user.update(about: params[:user][:about])
      render_turbo_stream(
        'replace',
        'member-description',
        'members/member_description',
        { user: current_user }
        )
    end
  end

  def edit_personal_details; end

  def update_personal_details
    if current_user.update(user_personal_info_params)
      render_turbo_stream(
        'replace',
        'member-personal-details',
        'members/member_personal_details',
        { user: current_user }
        )
    end
  end

  def connections
    @user = User.find(params[:id])
    @connected_users = if params[:mutual_connections].present?
                         mutual_connected_ids = current_user.mutually_connected_ids(@user)
                         User.where(id: mutual_connected_ids)
                       else
                         User.where(id: @user.connected_user_ids)
                       end
    @total_connections = @connected_users&.count
    @connected_users = @connected_users.page(params[:page]).per(10)
  end

  private

    def user_personal_info_params
      params.require(:user).permit(:first_name, :last_name, :city, :state, :country, :pincode, :profile_title)
    end
end 