class Project < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
  validates :body, presence: true

  def to_s
    name
  end

  def permalink
    "http://#{Rails.configuration.host}/projects/#{slug}"
  end

  def to_param
    "#{ self.id }-#{ self.slug }"
  end
end
