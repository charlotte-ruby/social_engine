module SocialEngine
  module Helpers  
    module User
      def name
        self.user ? self.user.name : self.unauthenticated_name
      end

      def email
        self.user ? self.user.email : self.unauthenticated_email
      end

      def website
        self.user ? self.user.website : self.unauthenticated_website
      end
    end
    
    module Fingerprint
      def self.fingerprint_type(able)
        ftype = [able]
        fingerprint = SocialEngineYetting.fingerprint_method rescue nil
        case fingerprint
        when "ip_address"
          ftype << :ip_address
        when "session_hash"
          ftype << :session_hash
        when "browser"
          ftype << :browser_fingerprint      
        when "ip_browser"
          ftype.concat [:ip_browser,:browser_fingerprint]
        when "none"
          ftype = [:none]
        end
        ftype
      end
    end
  end
end