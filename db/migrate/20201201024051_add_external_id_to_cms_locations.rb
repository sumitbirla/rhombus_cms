class AddExternalIdToCmsLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :cms_locations, :external_id, :string, after: :id
  end
end
