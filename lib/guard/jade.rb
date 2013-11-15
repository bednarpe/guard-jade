require 'guard'
require 'guard/guard'
require 'guard/watcher'
require 'guard/helpers/starter'
require 'guard/helpers/formatter'

module Guard
  class Jade < Guard
    include ::Guard::Helpers::Starter

    def act_on(directory, file)
      target = file.gsub('client/','').gsub('.jade','.html')
      FileUtils.mkdir_p(File.dirname(target))

      if system("jade #{file} -o #{target}")
        mtime = File.mtime(file)
        File.utime(mtime, mtime, file)
        file
      else
        raise Exception.new("Failed to compile.")
      end
    end
  end
end

