class AddTextLangToCoffeecard < ActiveRecord::Migration[6.0]
  def change
    add_column :coffeecards, :text_lang, :string
  end
end
