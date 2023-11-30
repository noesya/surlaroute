class MobilePhoneCleaner
  def self.clean(phone_number)
    return nil if phone_number.blank?
    new(phone_number).sanitized_phone_number
  end

  def initialize(phone_number)
    @phone_number = phone_number
    @sanitized_phone_number = phone_number
    sanitize
  end

  def sanitized_phone_number
    @sanitized_phone_number
  end

  private

  def sanitize
    remove_spaces
    remove_national_format
    remove_leading_zero
  end

  def remove_spaces
    @sanitized_phone_number = @sanitized_phone_number.delete(' ')
  end

  def remove_national_format
    return unless @sanitized_phone_number.start_with?('06', '07')
    @sanitized_phone_number = "+33#{@sanitized_phone_number[1..-1]}"
  end

  def remove_leading_zero
    return unless @sanitized_phone_number.start_with?('+330')
    @sanitized_phone_number = "+33#{@sanitized_phone_number[4..-1]}"
  end

end