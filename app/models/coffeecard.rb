class Coffeecard < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  I18n.t(:title)
  I18n.t(:description)

  validates :title, presence: true,
                    length: 1..50

  validates :description, presence: true,
                          length: 5..640

  validates :text_lang,
            inclusion: { in: I18n.available_locales.map(&:to_s) }
end
