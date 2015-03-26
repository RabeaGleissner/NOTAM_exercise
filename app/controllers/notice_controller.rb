class NoticeController < ApplicationController

  def index
    
  end

  def create

    input_array = params[:input].split("\n").collect do |line|
      line
    end

    @icao_code = icao_code(input_array)

    weekday(input_array)

    @notice = Notice.new(icao_code: @icao_code, mon: @mon, tue: @tue, wed: @wed, thu: @thu, fri: @fri, sat: @sat, sun: @sun)
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

  def weekday(input_array)
    array = split_array(input_array).flatten

  if array.include? "MON"
    index = array.index("MON")
    @mon = array[index+1]
    if @mon.include? ','
      @mon = array[index+1] + array[index+2]
    end
  end

  if array.include? "TUE"
    index = array.index("TUE")
    @tue = array[index+1] 
    if @tue.include? ','
      @tue = array[index+1] + ' ' + array[index+2]
    end 
  end

  if array.include? "WED"
    index = array.index("WED")
    @wed = array[index+1]  
    if @wed.include? ','
      @wed = array[index+1] + ' ' + array[index+2]
    end
  end

  if array.include? "THU"
    index = array.index("THU")
    @thu = array[index+1]  
    if @thu.include? ','
      @thu = array[index+1] + ' ' + array[index+2]
    end
  end

  if array.include? "FRI"
    index = array.index("FRI")
    @fri = array[index+1] 
    if @fri.include? ','
      @fri = array[index+1] + ' ' + array[index+2]
    end 
  end

  if array.include? "SAT"
    index = array.index("SAT")
    @sat = array[index+1]  
    if @sat.include? ','
      @sat = array[index+1] + ' ' + array[index+2]
    end
  end

  if array.include? "SUN"
    index = array.index("SUN")
    @sun = array[index+1]  
    if @sun.include? ','
      @sun = array[index+1] + ' ' + array[index+2]
    end
  end
      
  end

  def split_array(array)
    array.map do |line|
      line.split(' ')
    end
  end

end
