class Regroupement < ActiveRecord::Base
  # Relations
  belongs_to :association
  belongs_to :dispositif
  
  def dispositif_attribute=(disp_attribute)
    disp_attribute.each do |attribute|
      build_dispositif(attribute)
    end
  end
end
