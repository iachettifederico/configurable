require_relative "spec_helper"
require_relative "../lib/configurable"

class ConfigurableObject
  include Configurable
end

describe Configurable do
  subject { ConfigurableObject.new }  
  describe "#config" do
    it "is not nil" do
      subject.config.wont_be_nil
    end
    
    it "accepts a Hash as a parameter" do
      configs = { x: :x }
      
      subject.config configs
      
      subject.config.x.must_equal :x
    end
    
    it "accepts an object that responds to 'to_hash'" do
      configs = OpenStruct.new( to_hash: { x: :x } )
      
      subject.config configs
      
      subject.config.x.must_equal :x 
    end
    
    it "accepts an OpenStruct object" do
      configs = OpenStruct.new( x: :x )
      
      subject.config configs
      
      subject.config.x.must_equal :x
    end
    
    it "accepts a block with a parameter" do
      subject.config do |c|
        c.x = :x
      end
      
      subject.config.x.must_equal :x
    end
    
    # TODO: Make this test pass
    # it "accepts a block without parameters" do
    #   subject.config do
    #     x = :x
    #     y = :y
    #   end
    #   subject.config.must_equal( { x: :x, y: :y } )
    # end
    
    it "gives preference to the block" do
      subject.config( { x: :not_x, y: :y } ) do |c|
        c.x = :x
      end
      
      subject.config.x.must_equal :x
      subject.config.y.must_equal :y
    end
    
    describe "merging configs" do   
      
      it "merges configs" do
        first_config = { x: :x, y: :not_y }
        second_config = { y: :y, z: :z }
        
        subject.config first_config
        subject.config second_config
        
        subject.config.x.must_equal :x
        subject.config.y.must_equal :y
        subject.config.z.must_equal :z
      end
      
      it "merges configs if the argument responds to 'to_hash'" do
        first_config = { x: :x, y: :not_y }
        second_config = OpenStruct.new( to_hash: { y: :y, z: :z } )
        
        subject.config first_config
        subject.config second_config
        
        subject.config.x.must_equal :x
        subject.config.y.must_equal :y
        subject.config.z.must_equal :z
      end
      
      it "gets the original config if the argument is invalid" do
        first_config = { x: :x, y: :y }
        second_config = :invalid_config
        
        subject.config first_config
        subject.config second_config
        
        subject.config.x.must_equal :x
        subject.config.invalid_config.must_be_nil
      end
      
      it "merges a block" do
        first_config = { x: :x, y: :not_y }
        
        subject.config first_config 
        subject.config do |c|
          c.y = :y
          c.z = :z
        end
        
        subject.config.x.must_equal :x
        subject.config.y.must_equal :y
        subject.config.z.must_equal :z
      end
      
      describe "#config#clean" do
        it "cleans the configurations" do
          first_config = { x: :x, y: :y }  
          subject.config first_config
          subject.config.x.must_equal :x
          
          subject.config.clean
          
          subject.config.x.must_be_nil
        end

        it "cleans the configurations with a block" do
          first_config = { x: :x, y: :y }  
          subject.config first_config
          subject.config.x.must_equal :x
          
          subject.config do |c|
            c.clean
          end
          
          subject.config.x.must_be_nil
        end
      end
      
    end
    
  end
end
