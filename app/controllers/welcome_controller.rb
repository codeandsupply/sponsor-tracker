class WelcomeController < ApplicationController
  def index
    @total_invoiced = Invoice.all.map{|i| i.total}.sum
    @total_payments_received = Payment.sum :amount
    @total_invoices_unpaid = @total_invoiced - @total_payments_received
  end

  def about
    adapter = Rails.configuration.database_configuration[Rails.env]['adapter']
    if adapter == 'sqlite3'
      @db_server_version = ActiveRecord::Base.connection.execute('select sqlite_version()')[0][0]
      @db_adapter = "SQLite3"
    elsif adapter == 'postgresql'
      @db_server_version = ActiveRecord::Base.connection.execute('select version()').first['version']
      @db_adapter = "PostgreSQL"
    else
      @db_adapter = "Database"
      @db_server_version = "unknown"
    end
  end
end
