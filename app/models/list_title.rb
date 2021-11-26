class ListTitle < ApplicationRecord
    validates :show_id, :title, uniqueness: {message: "Must be unique."}

end
