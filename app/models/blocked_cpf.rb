class BlockedCpf < ApplicationRecord

  validates :cpf, uniqueness: true
  validate :cpf_is_valid

  def formatted_cpf
    self.cpf.to_s.gsub(/(\d{3})(\d{3})(\d{3})(\d{2})/, '\1.\2.\3-\4')
  end

end
