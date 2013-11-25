# encoding: UTF-8
require 'pry'
require 'action_mailer'

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  #:address => "localhost",
  #:port => 1025
  :address              => "mail.cs.helsinki.fi",
  :port                 => 587,
  :domain               => 'cs.helsinki.fi',
  :user_name            => 'username',
  :password             => 'passu',
  :authentication       => 'login',
  :enable_starttls_auto => true
  }
ActionMailer::Base.view_paths= "/Users/jamo/g/mailer"#File.dirname(__FILE__)
#metodi ja mailer kansioon saman niminen html.erb filu niin kaikki ok.

class Mailer < ActionMailer::Base

  def my_mail(email)
    mail( :to      => email,
          :from    => "User Name <username@cs.helsinki.fi>",
          reply_to: 'username@cs.helsinki.fi',
          :subject => "subject") do |format|
                format.text
                format.html
    end
  end
end


mls = Proc.new {|email|
  email_message = Mailer.my_mail email
  puts email
  email_message.deliver
  puts "deliverd to #{email}"
}

end
@emails = %W[
ex@example.fi
ex2@example.fi
]

@emails = @emails.uniq
@emails.each do |e|
  mls.call(e)
end
