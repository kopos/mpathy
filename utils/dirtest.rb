dir = "/home/poorna/Work/blusens/admin/utils"
ndir = "#{dir}/test"

if(File.exists?(ndir) == false && File.directory?(ndir) == false)
	puts 'creating directory'
	Dir.mkdir(ndir)
end

#if(!Dir.exists(ndir))
#	Dir.mkdir(ndir)
#end
