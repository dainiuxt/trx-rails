class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true, length: { minimum: 6, maximum: 30 }
  validates :password, length: { minimum: 12 }, if: -> { new_record? || changes[:password_digest] }

  # User statuses
  PENDING = "pending"
  APPROVED = "approved"
  REJECTED = "rejected"

  # Scopes
  scope :pending, -> { where(status: PENDING) }
  scope :approved, -> { where(status: APPROVED) }
  scope :rejected, -> { where(status: REJECTED) }

  # Instance methods
  def approved?
    status == APPROVED
  end

  def pending?
    status == PENDING
  end

  def rejected?
    status == REJECTED
  end

  def approve!
    update(status: APPROVED, approved_at: Time.current)
  end

  def reject!
    update(status: REJECTED)
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end
end
