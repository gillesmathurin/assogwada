class Mailing < ActiveRecord::Base
  
  def deliver(associations)
    QuestMailer.deliver_mailing(associations, self)
    update_attribute(:published_at, Time.now)
  end
  
end
