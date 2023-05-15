class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def cpf_is_valid
    result = true
    if self.cpf.present?
      temp_string = self.cpf.to_s
      array = temp_string.scan /[0-9]/
      result = false unless array.length == 11
      first_sum = 0
      second_sum = 0
      array[0..8].reverse_each.with_index(2) do |n, i|
        first_sum += n.to_i * i
      end
      first_mod = first_sum % 11
      dig_one = 11 - first_mod
      dig_one = 0 if dig_one >= 10
      result = false unless array[9].to_i == dig_one
      array[0..9].reverse_each.with_index(2) do |n, i|
        second_sum += n.to_i * i
      end
      sec_mod = second_sum % 11
      dig_two = 11 - sec_mod
      dig_two = 0 if dig_two >= 10
      result = false unless array[10].to_i == dig_two
      self.errors.add(:cpf, "inválido") unless result
    else
      self.errors.add(:cpf, "não pode ficar em branco")
    end
  end

end
