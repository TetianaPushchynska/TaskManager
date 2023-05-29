class Task < ApplicationRecord
  STATUSES = { todo: 'todo', in_progress: 'in_progress', review: 'review', done: 'done', cancelled: 'cancelled' }.freeze
  PRIORITIES = { high: 'high', medium: 'medium', low: 'low' }.freeze

  acts_as_paranoid
  audited

  belongs_to :user

  enum status: STATUSES
  enum priority: PRIORITIES

  scope :by_priority, ->(value) { where(priority: value) if value.present? }

  validates_presence_of :title, :description, :status, :priority
end
