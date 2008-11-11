require 'open4'

module Xen
  
  class VolumeGroup
    
    attr_reader :name, :size
  
    def initialize(name, size)
      @name = name
      @size = size
    end
  
    def self.find(name=nil)
      name ||= nil
      # XXX deal with not found error
      cmd = "vgs --options=vg_name,vg_size --separator=' ' --noheadings --units=g --nosuffix #{name}"
      output = Xen::Command.run cmd
      result = output.collect { |line|
        name, size = line.strip.split(' ')
        new name, size
      }
      name ? result[0] : result
    end
  
    def free
      cmd = "vgs --options=vg_free --separator=' ' --noheadings --units=g --nosuffix #{@name}"
      Xen::Command.run cmd
    end
    
  end
  
end