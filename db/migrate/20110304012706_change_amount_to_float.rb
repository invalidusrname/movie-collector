class ChangeAmountToFloat < ActiveRecord::Migration
  def self.up
    change_column(:box_office_films, :amount, :float)
  end

  def self.down
  end
end
