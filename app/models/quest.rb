# -*- encoding : utf-8 -*-
class Quest < ActiveRecord::Base
  validates_presence_of :nom, :nom_asso, :on => :create, :message => "ne peut être vide"
  
  protected
  
  def upload_questionnaire=(questionnaire_field)
    unless questionnaire_field.blank?
      self.filename = base_part_of(questionnaire_field.original_filename)
      self.file_url = "#{RAILS_ROOT}/questionnaires/" + self.nom_asso + "_" + filename  
      self.content_type = questionnaire_field.content_type.chomp
      # écriture du fichier
      f1 = File.new(self.file_url, "wb")
      f1.write(questionnaire_field.read)
      f1.close
    end
  end
  
  def base_part_of(file_name)
    File.basename(file_name).gsub(/[^\w._-]/, '')
  end
end
