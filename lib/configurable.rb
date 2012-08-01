require "configurable/version"

module Configurable
  def config( attrs={} )
    @config = OpenStruct( hashify(@config).merge( hashify(attrs)) )
    @config.define_singleton_method( :clean ) { marshal_load( {} ) }
    
    if !block_given?
      @config
    else
      yield @config
    end
    
  end

  private
  
  def OpenStruct( attrs )
    OpenStruct.new( hashify( attrs ) )
  end

   def hashify( obj )
    if obj.respond_to?(:to_hash)
      obj.to_hash
    elsif obj.class == OpenStruct
      obj.marshal_dump
    else
      {}
    end
  end
  
end
