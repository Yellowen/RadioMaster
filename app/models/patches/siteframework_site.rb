# Extend SiteFramework::Site class to add extra functionality
SiteFramework::Site.class_eval do

  include Faalis::Concerns::Authorizable

  # Setup required FS structre for current site instance
  after_create :setup_tree

  belongs_to :site_category
  belongs_to :user, class_name: 'Faalis::User'
  has_many :domains

  validates(:title, presence: true)
  validates(:site_category_id, presence: true)

  validates_associated :site_category
  validates_associated :user

  private

  def setup_tree
    FileUtils.mkdir_p "#{Rails.application.sites_tree}/#{id}/views"
  end
end
