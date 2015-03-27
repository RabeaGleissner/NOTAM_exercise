class NoticeController < ApplicationController

  def index
    
  end

  def create
    notam_array = params[:input].split("\r\n\r\n")

    notam_array.each do |data|
    @notice = Notice.new
    @notice.new_from_notam_array(data)
    
    unless @notice.destroyed?
     @notice.save 
   end
   end   

    redirect_to results_path
  end

  def results
    @notices = Notice.all    
  end


  private
  def notice_params
    params.permit(:input)
  end

end
