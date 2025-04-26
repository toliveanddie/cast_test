class CreateDaycasts < ActiveRecord::Migration[8.0]
  def change
    create_table :daycasts do |t|
      t.string :cast
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
