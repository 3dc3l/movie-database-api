class CreateCastsMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :casts_movies do |t|
      t.belongs_to :movie
      t.belongs_to :cast
    end
  end
end
