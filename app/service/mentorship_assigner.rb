class MentorshipAssigner

  attr_reader :developers

  def initialize(developers)
    @developers = developers
  end

  def perform
    success = false
    nr_of_mentors_needed = developers.count
    return {} unless nr_of_mentors_needed > 1

    while !success do # HACK HACK ugly HACK
      success = false

      # assignments = {}
      # developers.each{ |dev| assignments[dev.to_id] = [] }

      full_assignments = Hash.new {|h,k| h[k] = [] }
      begin
        # Assign senior developers
        max_number_of_mentorships = (nr_of_mentors_needed.to_f / senior_developers.count).ceil
        assignments = (senior_developers.shuffle * max_number_of_mentorships).take(nr_of_mentors_needed)
        developers.each_with_index do |dev, index|
          mentor = assignments[index]
          raise 'cannot mentor yourself' if mentor == dev # Fantastic solution
          full_assignments[dev] << mentor
        end

        # Assign junior developers
        max_number_of_mentorships = (nr_of_mentors_needed.to_f / junior_developers.count).ceil
        assignments = (junior_developers.shuffle * max_number_of_mentorships).take(nr_of_mentors_needed)
        developers.each_with_index do |dev, index|
          mentor = assignments[index]
          raise 'cannot mentor yourself' if mentor == dev # Fantastic solution
          full_assignments[dev] << mentor
        end

        success = true
      rescue
        nil
      end
    end

    full_assignments
  end


  protected


  def senior_developers
    @senior_developers ||= developers.select{ |dev| dev.senior? }
  end

  def junior_developers
    @junior_developers ||= developers.select{ |dev| dev.junior? }
  end

end
