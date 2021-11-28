class ListTitleSerializer < ActiveModel::Serializer
  attributes :id, :title, :genre, :year, :country, :published_at, :description

  def id
    object.show_id
  end

  def genre
    object.media_type
  end

  def year
    object.release_year
  end

  def published_at
    object.date_added.to_date
  end
end
