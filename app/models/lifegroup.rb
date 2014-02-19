class Lifegroup < ActiveRecord::Base
end

  # belongs_to :semester

  # # 1: name & description & categories
  # # 2: email address
  # # 3: privacy settings
  # # 4: review & submit

  # has_one :basic_info
  # has_one :contact_info

  # validate :validate_wizard_progress
  # validates :presence => :contact_info, :if => -> { basic_info.present? }

  # it "can't have a contact info without basic info"
  # it "can't have an invalid basic info"
  # it "can't have an invalid contact info"

  # def current_wizard_stage
  #   return :privacy if contact_info.present?
  #   return :contact_info if basic.present?
  #   return :basic_info
  # end

  # def validate_wizard_progress
  #   associations = [
  #     basic_info,
  #     contact_info,
  #   ].compact
  #   associations.each(&:validate!)
  # end
# end

# class ContactInfoController
  # def show
  #   not_found unless current_user.current_wizard_stage == :contact_info
  # end
# end

# class BasicInfo
  # ...
# end

# class ContactInfo
  # has_one :email_address
# end
