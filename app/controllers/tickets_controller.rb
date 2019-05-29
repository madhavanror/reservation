class TicketsController < ApplicationController

  # GET /tickets, Get All Tickets
  def index
    @tickets = Ticket.includes(:excavator).all
  end

  # GET /tickets/:id, Get A Ticket based on Id
  def show
    @ticket = Ticket.includes(:excavator).find(params[:id])
    @polygon = Ticket.convert_polygon(@ticket.digi_site_info)
  end
end
