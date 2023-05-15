class BlockedCpf < ApplicationRecord

  validates :cpf, uniqueness: true
  validate :cpf_is_valid

end
