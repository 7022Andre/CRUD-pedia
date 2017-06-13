class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :wikis
  belongs_to :role
  after_initialize :set_default_role

  private

  def set_default_role
  	self.role ||= Role.find_by_name('standard')
  end
end
