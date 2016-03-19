class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.text :message
      t.integer :sender_id
      t.integer :recipient_id
      t.datetime :read_at
  		t.boolean :removed_by_sender,    default: false
  		t.boolean :removed_by_recipient, default: false
  		t.boolean :read,                 default: false
  	  t.timestamps null: false
    end
  end
end
