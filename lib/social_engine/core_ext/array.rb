class Array
  def to_options_hash
    hash = {}
    self.each do |element|
      if element.is_a? Symbol
        hash[element] = {}
      elsif element.is_a? Hash
        hash[element.keys[0]] = element.values[0]
      end
    end
    hash
  end
end
