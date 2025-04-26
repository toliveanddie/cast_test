class Post < ApplicationRecord
	has_many :daycasts, dependent: :destroy
end
