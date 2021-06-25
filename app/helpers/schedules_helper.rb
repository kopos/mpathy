module SchedulesHelper
	def humanized(d)
		suffixes 	 = {1 => :st, 21 => :st, 31 => :st,
									2 => :nd, 22 => :nd,
									3 => :rd, 23 => :rd,
									0 => :th}
		month_name = [:january, :february, :march, :april, :may, :june, 
									:july, :august, :september, :october, :november, :december]
		suffix     = suffixes[d.day] || suffixes[0]
		time_str   = d.hour >= 12? "#{d.hour - 12}:#{d.min} PM" : "#{d.hour}:#{d.min} AM"
		date_str   = "#{d.day}#{suffix} #{month_name[d.month - 1].to_s.capitalize} \'#{d.year.to_s[2..3]}"

		return time_str + " " + date_str
	end
end
