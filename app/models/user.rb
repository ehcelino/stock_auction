class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { default: 0, admin: 1 }


  validate :cpf_is_valid
  validate :email_for_admin
  validates :email, :cpf, uniqueness: true
  validates :name, presence: true

  private

  def email_for_admin
    if self.email.present? && self.role.present? && self.role == 1
      unless self.email =~ /\A[\w.+-]+@leilaodogalpao.com.br/
        self.errors.add(:email, 'e-mail de administrador inválido')
      end
    end
  end


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
