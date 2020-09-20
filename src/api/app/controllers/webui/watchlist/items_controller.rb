class Webui::Watchlist::ItemsController < Webui::WebuiController
  before_action :require_login

  def create
    User.session!.watchlist_items.create!(watchlist_item_params)
  end

  def destroy
    User.session!.watchlist_items.find(params[:id]).destroy
  end

  private

  def watchlist_item_params
    params.require(:watchlist_item).permit(
      :watchable_id,
      :watchable_type
    )
  end
end
