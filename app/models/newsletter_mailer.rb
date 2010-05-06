class NewsletterMailer < ActionMailer::Base
  
  def newsletter(abonne, newsletter)
    subject         "Annuaire Asso-Guadeloupe Newsletter #{newsletter.id}"
    recipients      abonne
    from            ''
    sent_on         Time.now    
    body            :newsletter => newsletter
    content_type    "text/html"
  end  

end
