module User::WatchlistConcern
  def watchlist_watches?(record)
    watchlist_items.any? { |watchlist_item| watchlist_item.watchable == record }
  end
end
