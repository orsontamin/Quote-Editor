class Quote < ApplicationRecord
  validates :name, presence: true

  # 1) expression in lambda should be be executed every time a new quote is inserted into database
  # 2) second part in lambda instructs Rails to broadcast the HTML of the created quote
  # to the users that are subscribed to the 'quotes' stream and
  # prepended to the DOM node with the id of 'quotes'
  after_create_commit -> { broadcast_prepend_to 'quotes', partial: 'quotes/quote', locals: { quote: self }, target: 'quotes' }
end
