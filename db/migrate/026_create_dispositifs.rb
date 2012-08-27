# -*- encoding : utf-8 -*-
class CreateDispositifs < ActiveRecord::Migration
  def self.up
    create_table :dispositifs do |t|
      t.column :nom, :string
    end
    # remplissage de la table dispositifs (data migration)
    dispositifs = ["PEL", "CEL", "CLAS", "VVV", "REAAP", "Animation locale",
       "Centre de loisirs", "Envie d'Agir"]
    dispositifs.each do |d|
      Dispositif.create(:nom => d)
    end
  end

  def self.down
    drop_table :dispositifs
  end
end
