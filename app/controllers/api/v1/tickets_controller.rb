class Api::V1::TicketsController < API::BaseController

  # POST /api/v1/tickets, Log A Ticket
  def create
    status, object, errors = Ticket.create_ticket(ticket_params,excavator_params)
    if status
      render json: individual_json(object).merge(message: 'Saved Successfully..!',), status: :created
    else
      render json: {message: 'Could not able to create with the given params', errors: errors}, status: :unprocessable_entity
    end
  end

  # GET /api/v1/tickets/ticket/:id, Get A Ticket based on Id
  def show_ticket
    ticket  = Ticket.includes(:excavator).find_by(id: params[:id])
    if ticket.present?
      render json: individual_json(ticket)
    else
      render json: {message: 'Record Not Found'}, status: :not_found
    end  
  end

  # GET /api/v1/tickets/show_tickets, Get All Tickets
  def show_tickets
    tickets = Ticket.includes(:excavator).all
    if tickets.present?
      render json: index_json(tickets)
    else
      render json: {message: 'Records Not Found'}, status: :not_found
    end
  end

  private

  def ticket_params
    {
      request_number: params[:RequestNumber],
      sequence_number: params[:SequenceNumber],
      request_type: params[:RequestType],
      primary_sa_code: params.dig(:ServiceArea, :PrimaryServiceAreaCode, :SACode),
      additional_sa_code: params.dig(:ServiceArea, :AdditionalServiceAreaCodes, :SACode),
      digi_site_info: params.dig(:ExcavationInfo, :DigsiteInfo, :WellKnownText),  
      due_date_time: params.dig(:DateTimes, :ResponseDueDateTime)
    }
  end

  def excavator_params
    {
      company_name: params.dig(:Excavator, :CompanyName),
      address: params.dig(:Excavator,:Address),
      city: params.dig(:Excavator, :City),
      state: params.dig(:Excavator, :State),
      zip_code: params.dig(:Excavator, :Zip),
      crew_on_site: params.dig(:Excavator, :CrewOnsite).to_s == 'true'
    }
  end
end
