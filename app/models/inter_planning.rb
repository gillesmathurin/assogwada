# -*- encoding : utf-8 -*-
# Nondatabase model to allow better recording of Planning
class InterPlanning
  
  # attr_reader :jours
  attr_accessor :activite_id, :stime_mat, :etime_mat, :stime_apm, :etime_apm, :lundi, :mardi, :mercredi, :jeudi,
   :vendredi, :samedi, :dimanche, :jours
    
  def initialize(params)
    @jours = []
    @stime_mat = params[:stime_mat] 
    @etime_mat = params[:etime_mat]
    @stime_apm = params[:stime_apm] 
    @etime_apm = params[:etime_apm]
    @lundi = params[:lundi]
    @mardi = params[:mardi]
    @mercredi = params[:mercredi]
    @jeudi = params[:jeudi]
    @vendredi = params[:vendredi]
    @samedi = params[:samedi]
    @dimanche = params[:dimanche]
    @activite_id = nil
  end
  
  # Constant
  DAYS = ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"]
  
  def stime=(time)
    stime = time
  end
  
  def etime=(time)
    etime = time
  end
end
