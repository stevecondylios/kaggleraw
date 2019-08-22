class AddLanguageToKaggle < ActiveRecord::Migration[5.2]
  def change
    add_column :kaggles, :language, :string
  end
end
