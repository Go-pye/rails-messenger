class Conversation < ApplicationRecord
  belongs_to :participant1, class_name: 'User'
  belongs_to :participant2, class_name: 'User'
  has_many :messages
end
