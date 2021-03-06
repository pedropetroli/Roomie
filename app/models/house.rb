class House < ActiveRecord::Base
  if Rails.env.development?
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg"
  else
    has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg",
        :storage => :dropbox,
        :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
        :path => ":style/:id_:filename"
  end
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :name, :address, :rental, presence: true
  validates :rental, numericality: { greater_than: 0}
  validates :image, :attachment_presence => true

  belongs_to :user, dependent: :destroy
  has_many :rentings
  has_many :reviews
  has_many :calendars
end