class CreateInventoryTables < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name, null: false
    end

    create_table :albums do |t|
      t.string :title, null: false
      t.string :recording_type, null: false
      t.integer :band_id, null: false
    end

    create_table :tracks do |t|
      t.string :title, null: false
      t.string :is_bonus, null: false, default: 'F'
      t.integer :album_id, null: false
    end

    add_index :bands, :name

    add_index :albums, :title
    add_index :albums, :band_id

    add_index :tracks, :title
    add_index :tracks, :album_id
  end
end
