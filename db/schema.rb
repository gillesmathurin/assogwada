# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100506152020) do

  create_table "abonnes", :force => true do |t|
    t.string   "nom_abonne"
    t.string   "email_abonne"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activites", :force => true do |t|
    t.string  "nom"
    t.decimal "tarif_mensuel",        :precision => 8, :scale => 2
    t.text    "modalite_inscription"
    t.text    "info_supp"
    t.string  "spectateur"
    t.boolean "besoin_habilitation",                                :default => false
    t.integer "association_id"
    t.decimal "licence",              :precision => 8, :scale => 2
    t.string  "spectage"
    t.string  "tarif_seance"
  end

  create_table "adhesions", :force => true do |t|
    t.integer "association_id", :null => false
    t.integer "membre_id",      :null => false
  end

  create_table "agrements", :force => true do |t|
    t.integer "association_id"
    t.integer "orgahab_id"
    t.string  "nom"
  end

  create_table "assoc_manifs", :force => true do |t|
    t.integer "association_id"
    t.integer "manifestation_id"
  end

  add_index "assoc_manifs", ["association_id", "manifestation_id"], :name => "asso_manif_idx"

  create_table "associations", :force => true do |t|
    t.string   "nom"
    t.string   "adresse_siegesocial"
    t.string   "ville"
    t.string   "telephone"
    t.string   "fax"
    t.string   "email"
    t.string   "website_url"
    t.text     "objet_social"
    t.integer  "cotisation_annuelle",     :limit => 10, :precision => 10, :scale => 0
    t.integer  "droit_entree",            :limit => 10, :precision => 10, :scale => 0
    t.integer  "nb_adherent_homme"
    t.integer  "nb_adherent_femme"
    t.integer  "nb_adherent_enfant"
    t.integer  "nb_adherent_adulte"
    t.boolean  "est_employeur"
    t.string   "chiffre_affaire"
    t.integer  "part_ressource_propre"
    t.integer  "part_subvention_public"
    t.integer  "pcent_subvrecu_subvsoll"
    t.datetime "created_at"
    t.text     "motivation_creation"
    t.date     "date_creation"
    t.integer  "total_adherent"
    t.integer  "part_subvention_prive"
    t.string   "nom_contact"
    t.string   "coordonnees_contact"
    t.integer  "siret"
    t.string   "ape"
    t.integer  "convention_id"
    t.boolean  "app_conv"
    t.string   "sigle"
    t.string   "code_postal"
    t.string   "permalink"
    t.string   "state"
    t.boolean  "incomplete"
    t.integer  "locals_count",                                                         :default => 0
    t.integer  "activites_count",                                                      :default => 0
    t.integer  "conseiladmins_count",                                                  :default => 0
    t.string   "email2"
  end

  add_index "associations", ["nom", "sigle", "ville"], :name => "assos_idx"

  create_table "associations_champ_interventions", :force => true do |t|
    t.integer "association_id"
    t.integer "champ_intervention_id"
  end

  add_index "associations_champ_interventions", ["association_id", "champ_intervention_id"], :name => "assos_ci_join_idx"

  create_table "besoin_humains", :force => true do |t|
    t.string  "categorie"
    t.integer "quantite"
    t.integer "association_id"
    t.text    "description"
  end

  create_table "besoin_materiels", :force => true do |t|
    t.string  "categorie"
    t.text    "desc"
    t.integer "quantite"
    t.integer "association_id"
  end

  create_table "champ_interventions", :force => true do |t|
    t.string "nom"
  end

  add_index "champ_interventions", ["nom"], :name => "index_champ_interventions_on_nom"

  create_table "conseiladmins", :force => true do |t|
    t.integer "association_id"
  end

  create_table "conv_pluris", :force => true do |t|
    t.integer "association_id"
    t.integer "orgahab_id"
    t.string  "nom_conv"
  end

  create_table "conventions", :force => true do |t|
    t.string "nom"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "dispositifs", :force => true do |t|
    t.string "nom"
  end

  create_table "locals", :force => true do |t|
    t.string  "adresse"
    t.string  "ville"
    t.integer "association_id"
    t.string  "telephone"
    t.string  "cp"
  end

  create_table "mailings", :force => true do |t|
    t.string   "objet"
    t.text     "body"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "recipients"
  end

  create_table "manifestations", :force => true do |t|
    t.string  "nom"
    t.string  "spectateur"
    t.integer "prix"
    t.text    "modalite_inscription"
    t.text    "infos_sup"
    t.string  "lieu"
    t.string  "nature"
    t.string  "lieu_inscription"
    t.string  "nom_resp"
    t.string  "coordonees"
    t.boolean "gratuit",              :default => false
    t.string  "spectage"
    t.text    "partenaires"
  end

  create_table "membres", :force => true do |t|
    t.string  "type"
    t.string  "nom"
    t.string  "prenom"
    t.string  "telephone"
    t.string  "mobile"
    t.string  "fax"
    t.string  "sexe"
    t.string  "tranche_age"
    t.string  "email"
    t.boolean "is_contact"
    t.time    "dbt_presence"
    t.time    "fin_presence"
    t.integer "conseiladmin_id"
  end

  create_table "newsletters", :force => true do |t|
    t.datetime "date_pub"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nl_contents", :force => true do |t|
    t.string   "titre"
    t.text     "body"
    t.integer  "newsletter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orgahabs", :force => true do |t|
    t.string "nom"
  end

  create_table "plannings", :force => true do |t|
    t.string  "jour"
    t.time    "hmat_debut"
    t.time    "hmat_fin"
    t.integer "activite_id"
    t.string  "type"
    t.date    "date"
    t.integer "manifestation_id"
    t.integer "local_id"
    t.time    "hapm_debut"
    t.time    "hapm_fin"
  end

  create_table "quests", :force => true do |t|
    t.string   "nom"
    t.string   "nom_asso"
    t.string   "file_url"
    t.string   "content_type"
    t.string   "filename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regroupements", :force => true do |t|
    t.integer "association_id"
    t.integer "dispositif_id"
  end

  create_table "salaries", :force => true do |t|
    t.string  "poste"
    t.string  "sexe"
    t.integer "association_id"
    t.string  "contrat_classique"
    t.string  "contrat_aide"
  end

  create_table "schema_info", :id => false, :force => true do |t|
    t.integer "version"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
  end

end
