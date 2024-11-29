class ChangeRatingToBeDecimalInMovies < ActiveRecord::Migration[7.1]
  def change
    change_column :movies, :rating, :decimal
  end
end
