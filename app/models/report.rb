class Report < ActiveRecord::Base
  attr_accessible :description, :name, :start, :type
end
