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

  def other_user(current_user_id)
    current_user_id == participant1_id ? participant2_id : participant1_id
  end
end
