class Contact < ActionMailer::Base
  helper :application
  default from: "junction@kristjanrang.eu"

  def new_message(message, from)
    @message = message
    @from = from
    mail from: "junction@kristjanrang.eu",
         subject: "New message",
         to: "mail@kristjanrang.eu"
  end

  # :nocov:
  class Preview < MailView
    def new_message
      Contact.new_message("Some message yo", "random@email.com")
    end
  end
  # :nocov:
end
