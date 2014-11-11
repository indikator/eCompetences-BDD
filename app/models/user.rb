class User < ActiveRecord::Base
  has_secure_password
  has_and_belongs_to_many :groups, class_name: 'UserGroup'

  def tipycal?
    groups.collect { |g| g.name }.include? "ECOMPETENCES_USERS"
  end
end
