class Notice < ActiveRecord::Base

  # validate :contains_phrase

  #Method to create a single notam from the input of several notams.
  def new_from_notam_array(data)

    input_array = data.split("\n").collect do |line|
      line
    end
  
    self.icao_code = extract_icao_code(input_array)
    
    single_day(input_array)

    several_days(input_array)
    
  end

  # Method to extract icao code from input
    def extract_icao_code(input_array)
    array = split_array(input_array)

     icao_array = array.select {|x| x.include?("A)")}.flatten
     icao_array[1]
    end

  # Method to save opening times for individual days
    def single_day(input_array)
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

  # Method to save opening times for several days
  def several_days(input_array)
     array = split_array(input_array).flatten

  # starting with monday
   if array.any? { |s| s.include?('MON-') }
     index = array.index{|s| s.include?("MON-")}
     @mon = array[index+1]

     if @mon.include? ','
       @mon = array[index+1] + array[index+2]
     end
     day = array[index][/.*-([^-]*)/,1].downcase.to_sym
     instance_variable_set("@#{day}", @mon)
   end

  # starting with tuesday
   if array.any? { |s| s.include?('TUE-') }
     index = array.index{|s| s.include?("TUE-")}
     @tue = array[index+1]

     if @tue.include? ','
       @tue = array[index+1] + array[index+2]
     end
     day = array[index][/.*-([^-]*)/,1].downcase.to_sym
     instance_variable_set("@#{day}", @tue)
   end

   # starting with wednesday
    if array.any? { |s| s.include?('WED-') }
      index = array.index{|s| s.include?("WED-")}
      @wed = array[index+1]

      if @wed.include? ','
        @wed = array[index+1] + array[index+2]
      end
      day = array[index][/.*-([^-]*)/,1].downcase.to_sym
      instance_variable_set("@#{day}", @wed)
    end

    # starting with thursday
     if array.any? { |s| s.include?('THU-') }
       index = array.index{|s| s.include?("THU-")}
       @thu = array[index+1]

       if @thu.include? ','
         @thu = array[index+1] + array[index+2]
       end
       day = array[index][/.*-([^-]*)/,1].downcase.to_sym
       instance_variable_set("@#{day}", @thu)
     end

     # starting with friday
      if array.any? { |s| s.include?('FRI-') }
        index = array.index{|s| s.include?("FRI-")}
        @fri = array[index+1]

        if @fri.include? ','
          @fri = array[index+1] + array[index+2]
        end
        day = array[index][/.*-([^-]*)/,1].downcase.to_sym
        instance_variable_set("@#{day}", @fri)
      end

      # starting with saturday
       if array.any? { |s| s.include?('SAT-') }
         index = array.index{|s| s.include?("SAT-")}
         @sat = array[index+1]

         if @sat.include? ','
           @sat = array[index+1] + array[index+2]
         end
         day = array[index][/.*-([^-]*)/,1].downcase.to_sym
         instance_variable_set("@#{day}", @sat)
       end

       # starting with sunday
        if array.any? { |s| s.include?('SUN-') }
          index = array.index{|s| s.include?("SUN-")}
          @sun = array[index+1]

          if @sun.include? ','
            @sun = array[index+1] + array[index+2]
          end
          day = array[index][/.*-([^-]*)/,1].downcase.to_sym
          instance_variable_set("@#{day}", @sun)
        end


  end

    def split_array(array)
      array.map do |line|
        line.split(' ')
      end
    end




  # def contains_phrase
  #  unless @notice.include? "AERODROME HOURS OF OPS/SERVICE"

  #   errors.add("Sorry, you can't submit this because you didn't include the phrase ‘AERODROME HOURS OF OPS/SERVICE’ ")
  #   end
  # raise
  # end


end
