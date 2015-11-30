# encoding: UTF-8
require 'action_mailer'

$USERNAME = ENV['USERNAME']
$PASSWORD = ENV['PASSWORD']





ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  #:address => "localhost",
  #:port => 1025
  :address              => "mail.cs.helsinki.fi",
  :port                 => 587,
  :domain               => 'cs.helsinki.fi',
  :user_name            =>  $USERNAME,
  :password             =>  $PASSWORD,
  :authentication       => 'login',
  :enable_starttls_auto => true

  }
ActionMailer::Base.view_paths= File.dirname(__FILE__)
#metodi ja mailer kansioon saman niminen html.erb filu niin kaikki ok.

class Mailer < ActionMailer::Base

  def my_mail(email)
    mail(:to      => email,
         :bcc     => "my-email-copy@example.com",
         :from    => "Me <me@example.com>",
         :reply_to=> 'reply-addr@example.com',
         :subject => "TITLE") do |format|
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




@emails = %W[
testaddr@example.com
]

if ARGV[0]
  @emails << File.read(ARGV[0]).split("\n")
  @emails << "sending-complete@example.com"
  @emails.flatten!
end

puts "Sending " <<  @emails.size << " emails"

$fails = []
@emails = @emails.uniq
@emails.each do |e|
  begin
    mls.call(e)
  rescue => ee
    $fails << [e, ee]
    p EMAIL: e
  end
end

puts $fails
