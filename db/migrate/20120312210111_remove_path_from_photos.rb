class RemovePathFromPhotos < ActiveRecord::Migration
  def up
    remove_column :photos, :path
  end

  def down
  end
end
