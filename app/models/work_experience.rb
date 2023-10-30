class WorkExperience < ApplicationRecord
  EMPLOYMENT_TYPE = ['Full-time', 'Part-time', 'Self-employed', 'Freelance', 'Trainee', 'Internship']
  LOCATION_TYPE = ['On-site', 'Hybrid', 'Remote']

  belongs_to :user

  validates :company, :start_date, :job_title, :location, presence: true
  validates :employment_type, presence: true, inclusion: { in: EMPLOYMENT_TYPE, message: 'Not available employment type' }
  validates :location_type, presence: true, inclusion: { in: LOCATION_TYPE, message: 'Not available location type' }


  validate :work_exprience_last_date
  validate :presence_of_end_date
  validate :end_date_greater_than_start_date, if: :currently_not_working_here?

  def work_exprience_last_date
    if end_date.present? && currently_working
      errors.add(:end_date, 'Must be blank if currently working in this company')
    end
  end

  def presence_of_end_date
    if end_date.nil? && !currently_working
      errors.add(:end_date, 'Must be present if you are not working in this company any more')
    end
  end

  def currently_not_working_here?
    !currently_working
  end

  def end_date_greater_than_start_date
    return if end_date.nil?

    if end_date < start_date
      errors.add(:end_date, 'End date must be greater than start date')
    end
  end

  def company_with_employment_type
    "#{company} (#{employment_type})".strip
  end

  def job_location
    "#{location} (#{location_type})".strip
  end

  def job_duration
    months = if end_date.present?
                fetch_months(end_date)
            else 
              fetch_months(Date.today)
            end

    result = months.divmod(12)

    duration = "#{result.first} #{result.first > 1 ? 'years' : 'year'} #{result.last} #{result.last > 1 ? 'months' : 'month' }"

    if currently_working
        "#{start_date.strftime("%b %Y")} - Present (#{duration})"
    else
        "#{start_date.strftime("%b %Y")} - #{end_date.strftime("%b %Y")} (#{duration})"
    end
  end

  def fetch_months(last_date)
    ((last_date.year - start_date.year) * 12 + last_date.month - start_date.month - (last_date.day >= start_date.day ? 0 : 1)).round
  end
  
  
end
