class AddMerchantToItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :merchant, index: true
  end
end
