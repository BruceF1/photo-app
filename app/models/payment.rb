class Payment < ApplicationRecord
    attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year, :customer
    belongs_to :User

    def self.month_options
        Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i+1} - #{name}", i+1]}
    end

    def self.year_options
        (Date.today.year..(Date.today.year+10)).to_a
    end

    def process_payment
       #binding.pry
        # Create a Customer:
            customer = Stripe::Customer.create({
                source: 'tok_mastercard',
                email: email,
            })

            # Charge the Customer instead of the card:
            charge = Stripe::Charge.create({
                amount: 1000,
                currency: 'usd',
                customer: customer.id,
            })
            # YOUR CODE: Save the customer ID and other info in a database for later.

            # When it's time to charge the customer again, retrieve the customer ID.
            charge = Stripe::Charge.create({
                amount: 1500, # $15.00 this time
                currency: 'usd',
                customer: customer.id, # Previously stored, then retrieved
            })

    end
end

