class Url < ActiveRecord::Base
  # validates :Url, presence: true
  default_scope -> { order('id DESC') }
end
