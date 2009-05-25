class QuestMailer < ActionMailer::Base
  
  def mailing(associations, mailing)
    subject mailing.objet
    from "postmaster@guadeloupe-asso.fr"
    recipients "gwadaman30@gmail.com"
    cc associations
    bcc associations
    body :mailing => mailing
    sent_on Time.now
    charset 'UTF-8'
    content_type "text/html"    
  end

  def sent(questionnaire)
    @subject    = 'Questionnaire rempli provenant de ' + questionnaire.nom_asso
    @body       = {"questionnaire" => questionnaire}
    @recipients = 'gwadaman30@gmail.com'
    @cc         = 'francoise.redon@wanadoo.fr'
    # @from       = 'gilles@guadeloupe-asso.fr' # a remplacer par l'attribut email de questionnaire
    @sent_on    = Time.now
    @headers    = {}
    @charset = 'UTF-8'
    
    quest = questionnaire.file_url 
    content_type = case File.extname(quest) 
    when ".doc"; "application/msword" 
    else; "application/octet-stream" 
    end 
    attachment :content_type => content_type, 
    :body => File.read(quest), 
    :filename => File.basename(quest)
  end
  
  def sent_inscription(association)
    @subject    = "Formulaire d'inscription"
    @body       = {"association" => association}
    @recipients = 'gwadaman30@gmail.com'
    @cc         = 'guadeloupe.asso@orange.fr'
    # @from       = 'gilles@guadeloupe-asso.fr'
    @sent_on    = Time.now
    @header     = {}
    @charset    = 'UTF-8'
  end
  
  def sent_formabonnement(contacts)
    @subject = "Demande de creation de site web"
    @body = { "contacts" => contacts}
    @recipients = 'gwadaman30@gmail.com'
    @sent_on = Time.now
    @header = {}
    @charset = 'UTF-8'
  end
  
  def confirmation_abo(contacts)
    @subject = "Confirmation de la demande de création de site web"
    @body = { "contacts" => contacts}
    @recipients = contacts[:email]
    @sent_on = Time.now
    @header = {}
    @charset = 'UTF-8'
  end
  
  def confirm_abonewsletter(abonne)
    @subject = "Confirmation de votre abonnement à notre newsletter"
    @body = { "abonne" => abonne }
    @recipients = abonne.email_abonne
    @sent_on = Time.now
    @header = {}
    @charset = 'UTF-8'
  end
end
