class Newsletter < ActiveRecord::Base
  has_many :nl_contents
  
  def deliver
    #find all the abonnes emails
    @abonnes = Abonne.all.collect(&:email)
    # Sends the newsletter to each one
    @abonnes.each do |abonne|
      NewsletterMailer.deliver_newsletter(abonne, self)
    end
    # Set the delivered_at time to now
    self.update_attribute(:delivered_at, Time.now)
  end
end