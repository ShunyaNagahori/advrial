class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  before_create :set_account_name

  has_one_attached :image
  has_many :advrials, dependent: :destroy
  has_many :places, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship', foreign_key: :follower_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower


  VALID_ACCOUNT_NAME_REGEX = (/\A[a-zA-Z0-9]+\z/).freeze

  enum gender: { no_answer: 0, man: 1, woman: 2 }
  validates :account_name, uniqueness: true,
                           length: { minimum: 6, maximum: 20 },
                           format: { with: VALID_ACCOUNT_NAME_REGEX },
                           on: :update # update時のみバリデーションを適用
                           
  validates :name, format: { with: /\A[^@]*\z/, multiline: true, message: :at_mark_ban }


  def to_param
    account_name
  end

  def self.ransackable_attributes(auth_object = nil)
    ["account_name", "name"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["active_relationships", "advrials", "followers", "following", "image_attachment", "image_blob", "passive_relationships"]
  end

  private
    def set_account_name
      # while doで行っているのは、「空の時追加->終了」では他のアカウントと被る可能性がある為、find_byの方も行って被りがあればもう一度実行するようにしている
      while self.account_name.blank? || User.find_by(account_name: self.account_name).present? do
        self.account_name = SecureRandom.hex(10)
      end
    end
end
