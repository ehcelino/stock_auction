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
  validate :cpf_is_blocked, on: :create
  validates :email, :cpf, uniqueness: true
  validates :name, presence: true
  has_many :bids
  has_many :auction_lots, through: :bids
  has_many :favorites
  has_many :favorite_auction_lots, through: :favorites, source: :auction_lot


  def is_favorite?(auction_lot)
    self.favorites.find_by(auction_lot_id: auction_lot.id) != nil
  end

  def user_email
    if self.admin?
      return "#{name} - #{email} (ADMIN)"
    end
    "#{name} - #{email}"
  end

  def block_user
    is_blocked = BlockedCpf.find_by(cpf: self.cpf)
    if  is_blocked != nil
      self.blocked!
    elsif self.blocked? && is_blocked == nil
      self.normal!
    end
  end

  private

  # def email_for_admin
  #   if self.email.present? && self.role.present? && self.role == "admin"
  #     unless self.email =~ /\A[\w.+-]+@leilaodogalpao.com.br/
  #       self.errors.add(:email, 'de administrador deve ter o domínio @leilaodogalpao.com.br')
  #     end
  #   end
  # end

  # def not_admin_email
  #   if self.email.present? && self.role.present? && self.role == "default"
  #     if self.email =~ /\A[\w.+-]+@leilaodogalpao.com.br/
  #       self.errors.add(:email, 'não pode pertencer a este domínio')
  #     end
  #   end
  # end

  def set_admin_by_email_domain
    if self.email.present?
      if self.email =~ /\A[\w.+-]+@leilaodogalpao.com.br/
        self.role = 1
      end
    end
  end

  def cpf_is_blocked
    if BlockedCpf.find_by(cpf: self.cpf) != nil
        self.errors.add(:cpf, 'está bloqueado para criação de nova conta')
    end
  end

end
