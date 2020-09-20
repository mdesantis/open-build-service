module Webui::ManageWatchlistConcern
  def set_watchlist_resources
    @watchable_record = main_object
    @watchlist_item = User.session!.watchlist_items.find_by({ watchable: @watchable_record })
  end
end
