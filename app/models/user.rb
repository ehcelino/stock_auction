class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { default: 0, admin: 1 }

  enum status: { normal: 0, blocked: 5 }

  validate :cpf_is_valid
  # validate :email_for_admin
  # validate :not_admin_email
  before_validation :set_admin_by_email_domain, on: :create
  validate :cpf_is_blocked
  validates :email, :cpf, uniqueness: true
  validates :name, presence: true
  has_many :bids
  has_many :auction_lots, through: :bids
  has_many :favorites
  has_many :favorite_auction_lots, through: :favorites, source: :auction_lot


  def is_favorite?(auction_lot)
    self.favorites.each do |fav|
      if auction_lot.id == fav.auction_lot_id
        return true
      end
    end
    false
  end

  def user_email
    if self.admin?
      return "#{name} - #{email} (ADMIN)"
    end
    "#{name} - #{email}"
  end

  def formatted_cpf
    self.cpf.to_s.gsub(/(\d{3})(\d{3})(\d{3})(\d{2})/, '\1.\2.\3-\4')
  end

  def block_user
    list = BlockedCpf.all.map {|x| x.cpf}
    unless list.count == 0
      if list.include?(self.cpf)
        self.status = 5
        self.save!(validate: false)
      end
    end
  end

  private

  def email_for_admin
    if self.email.present? && self.role.present? && self.role == "admin"
      unless self.email =~ /\A[\w.+-]+@leilaodogalpao.com.br/
        self.errors.add(:email, 'de administrador deve ter o domínio @leilaodogalpao.com.br')
      end
    end
  end

  def not_admin_email
    if self.email.present? && self.role.present? && self.role == "default"
      if self.email =~ /\A[\w.+-]+@leilaodogalpao.com.br/
        self.errors.add(:email, 'não pode pertencer a este domínio')
      end
    end
  end

  def set_admin_by_email_domain
    if self.email.present?
      if self.email =~ /\A[\w.+-]+@leilaodogalpao.com.br/
        self.role = 1
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

  def cpf_is_blocked
    list = BlockedCpf.all.map {|x| x.cpf}
    unless list.count == 0
      if list.include?(self.cpf)
        self.errors.add(:cpf, 'está bloqueado para criação de nova conta')
      end
    end
  end


end
