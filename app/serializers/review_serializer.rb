class ReviewSerializer < ActiveModel::Serializer
    attributes :id, :content, :rating
    belongs_to :user
    belongs_to :movie
  end
  