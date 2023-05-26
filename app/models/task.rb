class Task < ApplicationRecord
  STATUSES = { todo: 'todo', in_progress: 'in_progress', review: 'review', done: 'done', cancelled: 'cancelled' }.freeze
  PRIORITIES = { high: 'high', medium: 'medium', low: 'low' }.freeze

  belongs_to :user

  enum status: STATUSES
  enum priority: PRIORITIES
end
