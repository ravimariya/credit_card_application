class CreditCard < ApplicationRecord
  before_save :set_credit_limit

  def set_credit_limit
    maximum_possible_emi = (money_inflow/2 - money_outflow)
    credit_limit = maximum_possible_emi * find_terms(maximum_possible_emi)
    self.credit_limit = credit_limit
  end

  def find_terms(max_emi)
    return 24 if max_emi > 20000
    case max_emi
    when 0..5000
      6
    when 5001..10000
      12
    when 10001..20000
      18
    else
      0
    end
  end
end