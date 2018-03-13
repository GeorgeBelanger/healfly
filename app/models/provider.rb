class Provider < ApplicationRecord
	has_many :appointments, :dependent => :destroy
	has_many :appointments, :dependent => :delete_all


  mount_uploaders :image, ImageUploader
  mount_uploaders :qualification, QualificationUploader
  
  def provider?
    has_role?(:provider)
  end

  include PgSearch
  pg_search_scope :search_engine, :against => [:treatment, :location]
  scope :treatment, -> (input_treatment) { where("treatment ILIKE ?", "%#{input_treatment}%") }
  scope :location, -> (input_location) { where("location ILIKE ?", "%#{input_location}%") }
  scope :language, -> (input_language) { where("language ILIKE ?", "%#{input_language}%") }
  scope :min_price, -> (input_min_price) { where("price >= ?", input_min_price) }
  scope :max_price, -> (input_max_price) { where("price <= ?", input_max_price) }

end



