class CreateWatchlistItems < ActiveRecord::Migration[6.0]
  def up
    connection.execute <<~SQL.squish
      CREATE TABLE watchlist_items (
        id bigint NOT NULL AUTO_INCREMENT PRIMARY KEY,
        user_id INT(11) NOT NULL,
        watchable_type varchar(255) NOT NULL,
        watchable_id bigint NOT NULL,
        created_at datetime(6) NOT NULL,
        updated_at datetime(6) NOT NULL,
        INDEX index_watchlist_items_on_watchable_type_and_watchable_id (
          watchable_type, watchable_id
        ),
        UNIQUE INDEX index_watchlist_items_on_user_id_and_watchable (
          user_id, watchable_id, watchable_type
        ),
        CONSTRAINT fk_rails_077cf8f283 FOREIGN KEY (user_id) REFERENCES users (id)
      )
      SELECT
        user_id,
        project_id AS watchable_id,
        'Project' AS watchable_type,
        NOW() AS created_at,
        NOW() AS updated_at
      FROM
        watched_projects
      GROUP BY
        user_id,
        project_id
    SQL
  end

  def down
    drop_table :watchlist_items
  end
end
