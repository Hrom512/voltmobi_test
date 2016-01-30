class Task < ActiveRecord::Base
  belongs_to :user

  state_machine :state, :initial => :new do
    state :started
    state :finished
  end

  before_validation :on => :create do
    initialize_state_machines(:dynamic => :force)
  end

  validates :name, presence: true
end
