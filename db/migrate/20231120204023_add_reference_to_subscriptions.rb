class AddReferenceToSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_reference :subscriptions, :tea, null: false, foreign_key: true
  end
end
