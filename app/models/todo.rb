# frozen_string_literal: true

# == Schema Information
#
# Table name: todos
#
#  id          :bigint           not null, primary key
#  description :text
#  due_date    :date
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Todo < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[title due_date]
  end
end
