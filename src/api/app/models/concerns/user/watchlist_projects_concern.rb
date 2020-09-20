module User::WatchlistProjectsConcern
  def watchlist_project_names
    Rails.cache.fetch(['watchlist_project_names', self]) do
      watchlist_projects.order(:name).pluck(:name)
    end
  end

  def watchlist_add_project_by_name(name)
    watchlist_items.create!(watchable: Project.find_by!({ name: name }))
    watchlist_clear_projects_cache
  end

  def watchlist_remove_project_by_name(name)
    watchlist_items.join_projects.where(projects: { name: name }).delete_all
    watchlist_clear_projects_cache
  end

  # Needed to clear cache even when user's updated_at timestamp did not change,
  # aka. changes within the same second. Mainly an issue when in our test suite
  def watchlist_clear_projects_cache
    Rails.cache.delete(['watchlist_project_names', self])
  end

  def watchlist_watches_project_by_name?(name)
    watchlist_project_names.include?(name)
  end
end
