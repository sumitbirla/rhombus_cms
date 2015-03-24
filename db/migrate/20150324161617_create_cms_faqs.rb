class CreateCmsFaqs < ActiveRecord::Migration
  def change
    create_table :cms_faqs do |t|
      t.references :domain
      t.integer :sort, null: false
      t.string :question, null: false
      t.text :answer, null: false
      t.references :category, index: true

      t.timestamps null: false
    end
  end
end
