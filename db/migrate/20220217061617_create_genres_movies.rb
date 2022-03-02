class CreateGenresMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :genres_movies do |t|
      t.belongs_to :genre
      t.belongs_to :movie
    end
  end
end
