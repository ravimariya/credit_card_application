class CreditCardsController < ApplicationController
  def new
    @credit_card = CreditCard.new
  end

  def create
    credit_card = CreditCard.new(credit_card_params)
    if credit_card.save
      set_credibility_score(credit_card)
      redirect_to root_path, notice: "Credit card application submitted, application no. #{credit_card.id}"
    else
      redirect_to root_path, notice: 'Error'
    end
  end

  def set_credibility_score(credit_card)
    score = 0
    file = File.read('full_contact.json')
    res = JSON.parse(file)

    if res['status'] == 200
      social_profiles = res['socialProfiles'].collect{|r| r['type']}
      matched = ['linkedin', 'twitter', 'facebook'] & social_profiles
      score+=matched.count
      score+=1 if CreditCard.where(email: credit_card.email, system_suggestion: 'accept').any?
    end

    suggestion = score > 2 ? 'accept' : 'reject'
    credit_card.credibility_score = score
    credit_card.system_suggestion = suggestion
    credit_card.save!
  end

  private

  def credit_card_params
    params.require(:credit_card).permit(:email, :pan_card, :aadhar_card, :bank_account_number, :bank_ifsc_code, :money_inflow, :money_outflow)
  end
end
