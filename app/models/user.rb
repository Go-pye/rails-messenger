class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages
  has_many :conversations, through: :messages

  has_many :initiated_conversations, class_name: 'Conversation', foreign_key: 'participant1_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'participant2_id'

  scope :all_except, ->(user)  { where.not(id: user) }

  def conversations
    Conversation.where("participant1_id = ? OR participant2_id = ?", self.id, self.id)
  end

  def conversation_with(other_user)
    Conversation.where("(participant1_id = :user_id AND participant2_id = :other_user_id) OR
                        (participant1_id = :other_user_id AND participant2_id = :user_id)",
                        user_id: self.id, other_user_id: other_user.id).first
  end
end
