desc "Backup the Database"
task :backup_db => :environment do
  #load the database infos
  db_yaml_file = File.read(RAILS_ROOT + "/config/database.yml")
  DB_INFO = YAML.load(db_yaml_file).symbolize_keys
  dump_file = File.basename(Rails.root) + "-" + Time.now.strftime("%d-%m-%Y") + ".sql"
  # launch the shell script with the required arguments
  sh "#{current_path}/script/backup_db.sh #{DB_INFO[:production]["database"]} #{DB_INFO[:production]["username"]} #{DB_INFO[:production]["password"]} #{dump_file}"
end
