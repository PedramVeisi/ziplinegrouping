module Normalizer
  def self.normalize_email(email)
    return "" if email.nil? || email.strip.empty?

    email.strip.downcase
  end

  def self.normalize_phone(phone)
    return "" if phone.nil? || phone.strip.empty?

    digits = phone.gsub(/\D/, '')               # Remove all characters except digits
    digits.length == 10 ? "1#{digits}" : digits # Add country code (assuming all have a +1 code)
  end

end