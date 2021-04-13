class ImportMember
  attr_reader :organisation

  def initialise(organisation)
    @organisation = organisation
  end

  def perform
    result = []
    api = Envisage::Members.new(organisation.envisage_key)

    begin
      api.get
    rescue => e
      result << e.message
      return result
    end

    api.response_body.each do |row|
      update_member(row, result)
    end

    result
  end

  private

  def update_member(row, result)
    Member.find_or_create_by(email: row["email"]) do |r|
      r.organisation = organisation
      r.full_name = row["fullName"]
      r.role = set_employee_type(row)
      m = row["email"].match(/(?<extra>\+.*)@/)
      r.email = m.nil? ? row["email"] : row["email"].sub(m[:extra], '')
      r.phone =  set_phone(row)
      # r.envisage_key = row["token"]
      pass = SecureRandom.base64(12)
      r.password = pass
      r.password_confirmation = pass
      result << "New: #{r.full_name}, Email: #{r.email.inspect}, Password: #{pass.inspect}"
    end
  end

  def set_employee_type(row)
    row["employeeType"].blank? ? "archived" : row["employeeType"].downcase
  end

  def set_phone(row)
    row["mobileNumber"].blank? ? row["phoneNumber"] : row["mobileNumber"]
  end

end
