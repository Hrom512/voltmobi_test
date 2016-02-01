class Task < ActiveRecord::Base
  belongs_to :user
  has_many :attachments

  accepts_nested_attributes_for :attachments, :reject_if => :all_blank, :allow_destroy => true

  state_machine :state, :initial => :new do
    state :started
    state :finished
  end

  before_validation :on => :create do
    initialize_state_machines(:dynamic => :force)
  end

  validates :name, :user, presence: true
end
