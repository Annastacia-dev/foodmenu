class TestMailer < ApplicationMailer
  default from: 'info@webcafe.africa'

  def hello
    mail(
      subject: 'Hello from Postmark',
      to: 'annetotoh@gmail.com',
      from: 'info@webcafe.africa',
      html_body: '<strong>Hello</strong> dear Postmark user.',
      track_opens: 'true',
      message_stream: 'outbound')
  end
end
