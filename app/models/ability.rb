# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.task_author?
      can :manage, Task, user_id: user.id
    end
  end
end
