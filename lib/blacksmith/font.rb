module Blacksmith
  class Font
    include SmartProperties
    
    property :name, :required => true,
                    :converts => :to_s
    
    property :family, :required => true,
                      :converts => :to_s
                      
    property :copyright, :converts => :to_s
    
    property :ascent, :required => true,
                      :converts => :to_i,
                      :accepts => lambda { |number| number > 0 },
                      :default => 800
                      
    property :descent, :required => true,
                       :converts => :to_i,
                       :accepts => lambda { |number| number > 0 },
                       :default => 200

    property :weight, :required => true,
                      :default => 'Medium'
                      
    property :version, :required => true,
                       :converts => :to_s,
                       :accepts => lambda { |v| /\d+\.\d+(\.\d+)?/.match(v) },
                       :default => '1.0'
    
    property :filename, :required => true,
                        :converts => :to_s,
                        :accepts => lambda { |target| 
                          File.extname(target) == '.ttf' and 
                          File.directory?(File.dirname(target)) 
                        }
    
    def identifier
      name.gsub(/\W+/, '_')
    end
    
    def glyphs
      (@glyphs || []).dup
    end
    
    def <<(glyph)
      @glyphs ||= []
      @glyphs << glyph
    end
    
  end
end