class Hash
  def recursively_symbolize_keys!
    self.symbolize_keys!
    self.values.each do |v|
      if v.is_a? Hash
        v.recursively_symbolize_keys!
      elsif v.is_a? Array
        v.recursively_symbolize_keys!
      end
    end
    self
  end
  
  def optional_reverse_merge!(defaults,required=[],symbolize=true)
    defaults.recursively_symbolize_keys! if symbolize
    return self.reverse_merge!(defaults) if self.blank?
    defaults.each_pair do |k,v|
      if self[k]
        self[k].reverse_merge!(defaults[k])
      else
        self[k] = defaults[k] if required.include? k
      end
    end
    return self
  end
end