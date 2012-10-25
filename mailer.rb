require 'action_mailer'

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
   :address   => "posti.saunalahti.fi",
   :port      => 25,
   :domain    => "jamo.fi",
  }
ActionMailer::Base.view_paths= "/Users/jamo/g/mailer"#File.dirname(__FILE__)
#metodi ja mailer kansioon saman niminen html.erb filu niin kaikki ok.
#
#
class Mailer < ActionMailer::Base
  def daily_email
    @var = "var"

    mail(   :to      => "jamo@isotalo.fi",
            :from    => "jamo@jamo.fi",
            :subject => "paatyykohan taa spammiin?") do |format|
                format.text
                format.html
    end
  end
  
  def my_mail
    @name ="Jarmo"
    @pisteet = [1,2,3,4,5]
    mail(   :to      => "jamo@isotalo.fi",
            :from    => "jamo@jamo.fi",
            :subject => "paatyykohan taa spammiin?") do |format|
                format.html
    end    
  end
  
end

email = Mailer.my_mail#daily_email
puts email
email.deliver