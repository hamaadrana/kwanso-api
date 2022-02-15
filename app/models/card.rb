class Card < ApplicationRecord

  # Perfom Validations on Card

  validates :card, length: 20
  validates :cvv, length: 3
  validate :is_past?
  validates_numericality_of :amount, greater_than: 0.0

  private

  def is_past?
    submitted_date = Date.new(year, month).end_of_month
    today = Date.current

    errors.add :expiration_date, "Your card is expired" if today > submitted_date
  end
end
