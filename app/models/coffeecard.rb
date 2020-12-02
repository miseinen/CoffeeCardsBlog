class Coffeecard < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy

    I18n.t :title, :description

    VALID_TITLE_REGEX = /\A[a-zA-Z0-9]+\z/
    validates :title, presence: true,
                      format: { with: VALID_TITLE_REGEX }, 
                      length: 1..50

    VALID_DESCRIPTION_REGEX = /^[a-zA-Z0-9]+$/
    validates :description, presence: true,
                            format: { with: VALID_DESCRIPTION_REGEX, multiline: true }, 
                            length: 5..640

    validates :text_lang, inclusion: { :in => I18n.available_locales.map(&:to_s) }
end