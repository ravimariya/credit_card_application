class CreateCreditCards < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_cards do |t|
      t.string :email, null: false
      t.string :pan_card, null: false
      t.string :aadhar_card, null: false
      t.string :bank_account_number, null: false
      t.string :bank_ifsc_code, null: false
      t.integer :money_inflow, null: false
      t.integer :money_outflow, null: false
      t.string :credit_limit
      t.integer :credibility_score 
      t.string :system_suggestion
      t.timestamps
    end
  end
end
