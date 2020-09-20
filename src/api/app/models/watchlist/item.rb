class Watchlist::Item < ApplicationRecord
  self.table_name = 'watchlist_items'

  WATCHABLE_TYPES = %w[Project].freeze

  belongs_to :user, optional: false
  belongs_to :watchable, polymorphic: true, optional: false

  validates :user_id, uniqueness: { scope: [:watchable_type, :watchable_id] }
  validates :watchable_type, inclusion: { in: WATCHABLE_TYPES }
end

# == Schema Information
#
# Table name: watchlist_items
#
#  id             :bigint           not null, primary key
#  watchable_type :string(255)      not null, indexed => [user_id, watchable_id], indexed => [watchable_id]
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer          not null, indexed => [watchable_id, watchable_type]
#  watchable_id   :bigint           not null, indexed => [user_id, watchable_type], indexed => [watchable_type]
#
# Indexes
#
#  index_watchlist_items_on_user_id_and_watchable            (user_id,watchable_id,watchable_type) UNIQUE
#  index_watchlist_items_on_watchable_type_and_watchable_id  (watchable_type,watchable_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
