class Developer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :starting_date, type: Date
  field :image_url, type: String
  field :part_time, type: Boolean, default: false

  validates_presence_of :name, :starting_date

  scope :full_timers, -> { where(:part_time.in => [nil, false]) }

  def self.senior_latest_starting_date
    # Rails.cache.fetch(:senior_latest_starting_date) do
      all_devs = self.full_timers.order_by(starting_date: 'asc').to_a
      newest_senior_dev = if all_devs.count > 1
        highest_senior_index = (all_devs.count.to_f / 2).floor.to_i - 1
        newest_senior_dev = all_devs[highest_senior_index]
      else
        all_devs.first
      end

      newest_senior_dev.try(:starting_date)
    # end
  end

  def self.reset_seniority_limit
    Rails.cache.delete(:senior_latest_starting_date)
  end

  def self.pick_random_full_time_dev
    full_timers.to_a.shuffle.first
  end


  def senior?
    return true unless self.class.senior_latest_starting_date
    starting_date <= self.class.senior_latest_starting_date
  end

  def junior?
    !senior?
  end

  def full_time?
    !part_time?
  end

  def to_id
    _id.to_s
  end

end
