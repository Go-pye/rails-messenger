class Conversation < ApplicationRecord
  belongs_to :participant1, class_name: 'User'
  belongs_to :participant2, class_name: 'User'
  has_many :messages

  scope :with_recent_messages, -> (user_id) {
    joins(:messages)
    .where('messages.created_at > ?', 60.minutes.ago)
    .where('participant1_id = ? OR participant2_id = ?', user_id, user_id)
    .distinct
  }

end
