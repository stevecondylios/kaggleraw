class CreateKaggles < ActiveRecord::Migration[5.2]
  def change
    create_table :kaggles do |t|
      t.string :link
      t.string :code

      t.timestamps
    end
  end
end
