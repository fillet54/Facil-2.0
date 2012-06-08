class AlterPhotoAlbumId < ActiveRecord::Migration
  def up
    execute (%Q{ALTER TABLE photos ALTER COLUMN album_id TYPE integer USING CAST(album_id AS integer)})
  end

  def down
    raise ActiveRecord::IrreversibleMigration.new
  end
end
