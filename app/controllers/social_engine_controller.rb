require 'digest/sha2'
module SocialEngineController

  def add_fingerprint_and_user_id(obj,save=false)
    obj[:ip_address]=request.remote_ip
    obj[:session_hash]=request.session_options[:id]
    obj[:browser_fingerprint]=browser_fingerprint
    obj[:user_id] = current_user.id if current_user
    obj.save if save
  end
  
  def add_able_rep(name,obj)
    able = able_method_name(obj)
    if obj and obj.send(able) and obj.send(able).respond_to?(:user)
      Reputation.add(name, obj.send(able).user) rescue nil
    end
  end
  
  def browser_fingerprint
    Digest::SHA2.hexdigest(request.user_agent+request.accept+request.accept_charset+request.accept_encoding+request.accept_language) rescue nil
  end
  
  def set_polymorphic_vars(obj,able_method=nil)
    able = able_method || able_method_name(obj)
    obj.send("#{able}_type=", request.path.split("/")[1].classify)
    obj.send("#{able}_id=", request.path.split("/")[2])
  end
  
  def able_method_name(obj)
    "#{obj.class.to_s.underscore}able"
  end
end