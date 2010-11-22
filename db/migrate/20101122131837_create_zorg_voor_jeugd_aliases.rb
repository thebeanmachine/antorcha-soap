class CreateZorgVoorJeugdAliases < ActiveRecord::Migration
  def self.up
    create_table :zorg_voor_jeugd_aliases do |t|
      t.integer :organization_id, :null => false
      t.string :organization_username, :null => false

      t.string :organisatie_naam
      t.string :organisatie_postcode
      t.string :organisatie_uuid
      t.string :gebruikersnaam_medewerker, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :zorg_voor_jeugd_aliases
  end
end
