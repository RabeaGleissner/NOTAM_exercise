class NoticeController < ApplicationController

  def index
    
  end

  def create

 

    input_array = params[:input].split("\n").collect do |line|
      line
    end

    @icao_code = icao_code(input_array)

    @notice = Notice.new(icao_code: @icao_code)
    @notice.save

    redirect_to results_path
  end

  def results
    
  end


  private
  def notice_params
    params.permit(:input)
  end

# Method to extract icao code from input
  def icao_code(input_array)
    array = input_array.map do |line|
      line.split(' ')
    end
   icao_array = array.select {|x| x.include?("A)")}
   icao_array.flatten[1]
  end

end
