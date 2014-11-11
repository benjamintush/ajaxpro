class Url < ActiveRecord::Base
  validates :url, presence: true
  default_scope -> { order('created_at DESC') }
end
