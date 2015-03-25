class NoticeController < ApplicationController

  def index
    
  end

  def create

    input_array = params[:input].split("\n").collect do |line|
      line
    end

    @icao_code = icao_code(input_array)

    @mon = monday(input_array)

    @notice = Notice.new(icao_code: @icao_code, mon: @mon)
    @notice.save

    redirect_to results_path
  end

  def results
    @notices = Notice.all    
  end


  private
  def notice_params
    params.permit(:input)
  end

# Method to extract icao code from input
  def icao_code(input_array)
  array = split_array(input_array)

   icao_array = array.select {|x| x.include?("A)")}.flatten
   icao_array[1]
  end

# Method to find Monday opening times
  def monday(input_array)
    array = split_array(input_array)

    monday = array.select {|x| x.include?("E)")}.flatten
    index = monday.index('MON')
    monday[index+1]    
  end

  def split_array(array)
    array.map do |line|
      line.split(' ')
    end
  end

end
