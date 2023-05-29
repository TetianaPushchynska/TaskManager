class Task < ApplicationRecord
  STATUSES = { todo: 'todo', in_progress: 'in_progress', review: 'review', done: 'done', cancelled: 'cancelled' }.freeze
  PRIORITIES = { high: 0, medium: 1, low: 2 }.freeze

  acts_as_paranoid
  audited

  belongs_to :user

  enum status: STATUSES
  enum priority: PRIORITIES

  scope :by_priority, ->(value) {
    Array(value).reject(&:blank?).present? ? where(priority: Array(value).reject(&:blank?)) : all
  }

  validates_presence_of :title, :description, :status, :priority
end
