class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true
  validates :name, presence: true
  has_many :meals, before_add: :check_meal_limit


  def check_meal_limit(meal)
    if self.meals.count == 10
      self.meals.first.destroy
    end
  end
end
