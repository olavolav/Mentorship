class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :name, type: String
  field :starting_date, type: Date, default: -> { Time.now.to_date }

  validates_presence_of :name, :starting_date

  def senior?
    true
  end

end
