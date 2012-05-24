class DashboardController < ApplicationController
  include HTTParty
  base_uri "aspires.pagerduty.com/api/v1"
  
  def initialize
    self.class.basic_auth("austinspires@gmail.com", "pagerdutypassword")
  end
  
  def show
    @unresolved = ack_unres.reverse
  end

  private

  def get_incidents()
    self.class.get("/incidents")["incidents"]
  end

  def get_unresolved
    self.class.get("/incidents?status=unresolved")["incidents"]
  end
  
  def get_ack
    self.class.get("/incidents?status=acknowleged")["incidents"]
  end
  
  def get_resolved 
    self.class.get("/incidents?status=resolved")["incidents"]
  end
  
  def ack_unres
    output = Array.new
    get_ack.each do |issue|
      get_resolved.include?(issue) ? next : output << issue
    end
    output
  end
  
end
