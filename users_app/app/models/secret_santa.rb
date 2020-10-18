class SecretSanta < ApplicationRecord
  has_many :users, dependent: :destroy
end
