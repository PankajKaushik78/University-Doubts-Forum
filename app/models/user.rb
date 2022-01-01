class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :doubts, dependent: :destroy
  has_many :categories, through: :doubts
  has_one :assistant, dependent: :destroy

  enum designation: { student: 0, assistant: 1, teacher: 2}


end
