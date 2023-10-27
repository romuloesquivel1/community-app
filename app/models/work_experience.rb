class WorkExperience < ApplicationRecord
  belongs_to :user

  validates :company, :start_date, :employment_type, :job_title, :location, :location_type, presence: true
  
  
end
