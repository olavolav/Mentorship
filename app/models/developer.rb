class Developer
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Mongoid::Attributes::Dynamic

  field :name, type: String
  field :starting_date, type: Date

  validates_presence_of :name, :starting_date

  def self.senior_latest_starting_date
    @@senior_latest_starting_date ||= begin
      all_devs = self.order_by(starting_date: 'asc').to_a
      limit_index = (all_devs.count.to_f / 2).to_i
      newest_senior_dev = all_devs[limit_index]
      newest_senior_dev.starting_date
    end
  end

  def self.reset_seniority_limit
    @@senior_latest_starting_date = nil
  end

  def senior?
    starting_date <= self.class.senior_latest_starting_date
  end

  def junior?
    !senior?
  end

  def to_id
    _id.to_s
  end

end
