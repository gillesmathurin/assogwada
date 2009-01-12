class ToolsController < ApplicationController

  def mailing
    @mailing = Mailing.new
  end
  
  def deliver_mailing
    @mailing = Mailing.new(params[:mailing])
    respond_to do |format|
      if @mailing.save
        call_rake(:send_mailing, :mailing_id => @mailing.id.to_i)
        flash[:notice] = "En cours d'envoi"
        redirect_to mailing_tools_url
      else
        flash[:notice] = "Vérifiez votre mailing"
        format.html { redirect_to mailing_tools_url }
      end
    end
  end

  def newsletter
  end

  def export_xls
  end

end
