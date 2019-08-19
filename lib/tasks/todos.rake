namespace :todos do
  desc "Mail Monthly"
  task mailmonth: :environment do
    MonthlyWorker.perform_async MonthlyWorker::MAIL_MONTH
  end
end
