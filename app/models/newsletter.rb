class Newsletter < ActiveRecord::Base
  has_many :nl_contents
  
  def contenu_nl_attributes=(cnl_attributes)
    cnl_attributes.each do |attributes|
      if attributes[:id].blank?
        self.nl_contents.build(attributes)
      else
        nl_content = nl_contents.detect { |nlc| nlc.id == attributes[:id].to_i }
        nl_content.attributes = attributes
      end
    end
  end
  
  def save_nl_contents
    nl_contents.each do |nlc|
      if nlc.should_destroy?
        nlc.destroy
      else
        nlc.save(false)
      end
    end
  end
  
  def deliver(abonnes)
    QuestMailer.deliver_sent_newsletter(abonnes, self)
    update_attribute(:date_pub, Time.now) 
  end
  
end
