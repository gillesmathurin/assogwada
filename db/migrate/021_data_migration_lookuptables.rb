# -*- encoding : utf-8 -*-
class DataMigrationLookuptables < ActiveRecord::Migration
  def self.up
    # creation données pour la table champ_interventions
    chp_intervs = ["Culture", "Education", "Sport", "Insertion", "Orientation, Information",
      "Formation", "Accompagnement social", "Humanitaire, l'aide sociale", "Médico-social",
      "Défense de l'environnement", "Défense des consommateurs et usagers",
       "Philosophie ou religion", "Association intermédiaire", "Association d'insertion"]
    chp_intervs.each do |e| 
      ChampIntervention.create(:nom => e)
    end
    
    # creation donnée pour la table orgahabs
    # orga_habs = []
    # for i in 1..10
    #   elt = "Ministère_#{i}"
    #   orga_habs << elt
    # end
    # orga_habs.each do |e|
    #   Orgahab.create(:nom => e)
    # end
    # 
    # #### creation des données pour la table associations
    # 
    #   #### tableaux de données ###
    #   
    # # Liste Communes-CodePostal
    # @ville = ["97139 Abymes (Les)", "97121 Anse-Bertrand",
    #   "97122 Baie-Mahault", "97123 Baillif", "97100 Basse-Terre",
    #   "97125 Bouillante", "97130 Capesterre Belle Eau", "97140 Capesterre de Marie Galante",
    #   "97126 Deshaies", "97127 Désirade (La)", "97190 Gosier (Le)", "97113 Gourbeyre",
    #   "97128 Goyave", "97112 Grand Bourg", "97129 Lamentin",
    #   "97111 Morne à L'Eau", "97160 Moule (Le)", "97170 Petit Bourg",
    #   "97131 Petit-Canal", "97110 Pointe à Pitre", "97116 Pointe Noire",
    #   "97117 Port Louis", "97180 Sainte Anne", "97133 Saint Barthélémy",
    #   "97120 Saint Claude", "97118 Saint François", "97134 Saint Louis",
    #   "97150 Saint Martin", "97115 Sainte Rose", "97136 Terre de Bas",
    #   "97137 Terre de Haut", "97114 Trois rivières", "97141 Vieux Fort",
    #   "97119 Vieux Habitants"]
    # 
    # for i in 1..3
    #   array = @ville.sort { rand(3)-1 } [0..(@ville.length - 1)]
    #   array.each do |ville|
    #     n = rand(1000)
    #     Association.create!(
    #        :nom => "Association_#{n}",
    #        :adresse_siegesocial => "#{n} rue de XXX",
    #        :ville => ville,
    #        :telephone => "0590802356" ,
    #        :fax => "0590453675" ,
    #        :email => "email@mail.com",
    #        :website_url => "http://www.adresse.asso.fr",
    #        :objet_social => "Eliquatuero dip numsan vent lam, conum facillum init lut
    #         doloreet ulla metuero od tet adit, commod tatumy feug tiam velit praese exer aute 
    #        enit alit, veliqua modit dolorer commod niam onul laore.
    #         Uptat prat lut lut iriliquat, quis alisl irilit am irillum at niam,
    #          verosto consequ ismodit iriuscin el dolorero prat lut lut iriliquat,
    #           quis alisl irilit am irillum at niam zzrit, verosto dionsequi veliqui
    #            exerit inis ea feugue verosto consequ commod dolorero ismodit feum.",
    #        :cotisation => 25,
    #        :droit_entree => 50,
    #        :nb_adherent_homme => 20,
    #        :nb_adherent_femme => 20,
    #        :nb_adherent_enfant => 15,
    #        :nb_adherent_adulte => 25,
    #        :motivation_creation => "Eliquatuero dip numsan vent lam, conum facillum
    #         init lut doloreet ulla metuero od tet adit, commod tatumy feug tiam velit
    #          praese exer aute")
    #   end
    # end
  end

  def self.down
    # Association.delete_all
    # Orgahab.delete_all
    ChampIntervention.delete_all
  end
end
