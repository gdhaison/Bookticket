class MonthlyWorker
  include Sidekiq::Worker

  MAIL_MONTH = 1
  def perform action
    case action
    when MAIL_MONTH
      send_email_when_end_month Movie.last
    end
  end

  private

  def send_email_when_end_month film
    UserMailer.mail_month(film).deliver_now
  end
end
