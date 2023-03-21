class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  before_create :set_account_name

  has_one_attached :image
  VALID_ACCOUNT_NAME_REGEX = (/\A[a-zA-Z0-9]+\z/).freeze

  enum gender: { no_answer: 0, man: 1, woman: 2 }
  validates :account_name, uniqueness: true,
                           length: { minimum: 6, maximum: 20 },
                           format: { with: VALID_ACCOUNT_NAME_REGEX },
                           on: :update # update時のみバリデーションを適用


  def to_param
    account_name
  end

  private
    def set_account_name
      # while doで行っているのは、「空の時追加->終了」では他のアカウントと被る可能性がある為、find_byの方も行って被りがあればもう一度実行するようにしている
      while self.account_name.blank? || User.find_by(account_name: self.account_name).present? do
        self.account_name = SecureRandom.hex(10)
      end
    end
end
