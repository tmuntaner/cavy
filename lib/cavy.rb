require "cavy/engine"

module Cavy
  
  mattr_accessor :root, :title

  def self.config(&block)
    yield(self)
  end

end