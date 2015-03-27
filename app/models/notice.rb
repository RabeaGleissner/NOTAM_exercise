class Notice < ActiveRecord::Base

  DAYS = [:mon, :tue, :wed, :thu, :fri, :sat, :sun]
  #Method to create a single notam from the input of several notams.
  def new_from_notam_array(data)
    input_array = data.split("\n").collect do |line|
      line
    end
    contains_phrase(input_array)
    self.icao_code = extract_icao_code(input_array) unless destroyed?
    single_day(input_array) unless destroyed?
    several_days(input_array) unless destroyed?
  end

  def contains_phrase(input_array)
   unless input_array.to_s.include? "AERODROME HOURS OF OPS/SERVICE"
      self.destroy
    end
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
      self.mon = array[index+1]
      if self.mon.include? ','
        self.mon = array[index+1] + array[index+2]
      end
    end

    if array.include? "TUE"
      index = array.index("TUE")
      self.tue = array[index+1] 
      if self.tue.include? ','
        self.tue = array[index+1] + ' ' + array[index+2]
      end 
    end

    if array.include? "WED"
      index = array.index("WED")
      self.wed = array[index+1]  
      if self.wed.include? ','
        self.wed = array[index+1] + ' ' + array[index+2]
      end
    end

    if array.include? "THU"
      index = array.index("THU")
      self.thu = array[index+1]  
      if self.thu.include? ','
        self.thu = array[index+1] + ' ' + array[index+2]
      end
    end

    if array.include? "FRI"
      index = array.index("FRI")
      self.fri = array[index+1] 
      if self.fri.include? ','
        self.fri = array[index+1] + ' ' + array[index+2]
      end 
    end

    if array.include? "SAT"
      index = array.index("SAT")
      self.sat = array[index+1]  
      if self.sat.include? ','
        self.sat = array[index+1] + ' ' + array[index+2]
      end
    end

    if array.include? "SUN"
      index = array.index("SUN")
      self.sun = array[index+1]  
      if self.sun.include? ','
        self.sun = array[index+1] + ' ' + array[index+2]
      end
    end    
  end

  # Method to save opening times for several days
  def several_days(input_array)
     array = split_array(input_array).flatten
     
  # starting with monday
   if array.any? { |s| s.include?('MON-') }
     index = array.index{|s| s.include?("MON-")}
     self.mon = array[index+1]

     if self.mon.include? ','
       self.mon = array[index+1] + array[index+2]
     end

     day = array[index][/.*-([^-]*)/,1].downcase.to_sym

     set_variables(day, self.mon)
     find_days_inbetween(:mon, mon, day)
   end

  # starting with tuesday
   if array.any? { |s| s.include?('TUE-') }
     index = array.index{|s| s.include?("TUE-")}
     self.tue = array[index+1]

     if self.tue.include? ','
       self.tue = array[index+1] + array[index+2]
     end
     day = array[index][/.*-([^-]*)/,1].downcase.to_sym
     set_variables(day, self.tue)
     find_days_inbetween(:tue, tue, day)
   end

   # starting with wednesday
    if array.any? { |s| s.include?('WED-') }
      index = array.index{|s| s.include?("WED-")}
      self.wed = array[index+1]

      if self.wed.include? ','
        self.wed = array[index+1] + array[index+2]
      end
      day = array[index][/.*-([^-]*)/,1].downcase.to_sym
      set_variables(day, self.wed)
      find_days_inbetween(:wed, wed, day)    
    end

    # starting with thursday
     if array.any? { |s| s.include?('THU-') }
       index = array.index{|s| s.include?("THU-")}
       self.thu = array[index+1]

       if self.thu.include? ','
         self.thu = array[index+1] + array[index+2]
       end
       day = array[index][/.*-([^-]*)/,1].downcase.to_sym
       set_variables(day, self.thu)
       find_days_inbetween(:thu, thu, day) 
     end

     # starting with friday
      if array.any? { |s| s.include?('FRI-') }
        index = array.index{|s| s.include?("FRI-")}
        self.fri = array[index+1]

        if self.fri.include? ','
          self.fri = array[index+1] + array[index+2]
        end
        day = array[index][/.*-([^-]*)/,1].downcase.to_sym
        set_variables(day, self.fri)
        find_days_inbetween(:fri, fri, day) 
      end

      # starting with saturday
       if array.any? { |s| s.include?('SAT-') }
         index = array.index{|s| s.include?("SAT-")}
         self.sat = array[index+1]

         if self.sat.include? ','
           self.sat = array[index+1] + array[index+2]
         end
         day = array[index][/.*-([^-]*)/,1].downcase.to_sym
         set_variables(day, self.sat)
         find_days_inbetween(:sat, sat, day) 
       end

       # starting with sunday
        if array.any? { |s| s.include?('SUN-') }
          index = array.index{|s| s.include?("SUN-")}
          self.sun = array[index+1]

          if self.sun.include? ','
            self.sun = array[index+1] + array[index+2]
          end
          day = array[index][/.*-([^-]*)/,1].downcase.to_sym
         set_variables(day, self.sun)
          find_days_inbetween(:sun, sun, day) 
        end
  end

  def set_variables(day, start_day)
    instance_variable_set("@#{day}", start_day)
    if @mon
      self.mon = @mon
    elsif @tue
      self.tue = @tue
    elsif @wed
      self.wed = @wed
    elsif @thu
      self.thu = @thu
    elsif @fri
      self.fri = @fri
    elsif @sat
      self.sat = @sat
    elsif @sun
      self.sun = @sun
    end  
  end

# Find days that aren't explicitly spelled out
  def find_days_inbetween(start_day_symbol, start_day_variable, end_day )
    i = DAYS.index(end_day)
      while i > DAYS.index(start_day_symbol)
        instance_variable_set("@#{DAYS[i-1]}", start_day_variable)
        i -= 1
          if @mon
            self.mon = @mon
          elsif @tue
            self.tue = @tue
          elsif @wed
            self.wed = @wed
          elsif @thu
            self.thu = @thu
          elsif @fri
            self.fri = @fri
          elsif @sat
            self.sat = @sat
          elsif @sun
            self.sun = @sun
          end
      end
  end

    def split_array(array)
      array.map do |line|
        line.split(' ')
      end
    end
end
