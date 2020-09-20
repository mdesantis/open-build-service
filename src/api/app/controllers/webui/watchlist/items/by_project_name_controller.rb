class Webui::Watchlist::Items::ByProjectNameController < Webui::WebuiController
  before_action :require_login

  def create
    User.session!.watchlist_add_project_by_name(params[:project_name])
  end

  def destroy
    User.session!.watchlist_remove_project_by_name(params[:project_name])
  end
end
