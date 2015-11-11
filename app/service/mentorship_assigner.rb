class MentorshipAssigner

  def initialize(developers)
    @developers = developers
  end

  def perform
    success = false
    return {} unless senior_developers.count > 1
    return {} unless junior_developers.count > 1

    nr_of_mentors_needed = developers.count
    while !success do # HACK HACK ugly HACK
      success = false

      full_assignments = Hash.new {|h,k| h[k] = [] }
      begin
        # Assign senior developers
        max_number_of_mentorships = (nr_of_mentors_needed.to_f / senior_developers.count).ceil
        assignments = (senior_developers.shuffle * max_number_of_mentorships).take(nr_of_mentors_needed).shuffle
        developers.each_with_index do |dev, index|
          mentor = assignments[index]
          raise 'cannot mentor yourself' if mentor == dev # Fantastic solution
          full_assignments[dev] << mentor
        end

        # Assign junior developers
        max_number_of_mentorships = (nr_of_mentors_needed.to_f / junior_developers.count).ceil
        assignments = (junior_developers.shuffle * max_number_of_mentorships).take(nr_of_mentors_needed).shuffle
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


  attr_reader :developers

  def senior_developers
    @senior_developers ||= full_time_developers.select(&:senior?)
  end

  def junior_developers
    @junior_developers ||= full_time_developers.select(&:junior?)
  end

  def full_time_developers
    developers.select(&:full_time?)
  end

end
