require 'rails_helper'

RSpec.describe Api::V1::TicketsController, type: :controller do
  let!(:ticket){ create(:ticket, request_number: '234567', request_type: 'Normal')}
  let!(:excavator){ create(:excavator, company_name: 'John Doe CONSTRUCTION', ticket: ticket) }
  let(:ticket_params) do 
    {
	  "ContactCenter": "UPCA",
	  "RequestNumber": "09252012-00001",
	  "ReferenceRequestNumber": "",
	  "VersionNumber": "0",
	  "SequenceNumber": "2421",
	  "RequestType": "Normal",
	  "RequestAction": "Restake",
	  "DateTimes": {
		  "RequestTakenDateTime": "2011/07/02 23:09:38",
		  "TransmissionDateTime": "",
		  "LegalDateTime": "2011/07/08 07:00:00",
		  "ResponseDueDateTime": "2011/07/13 23:59:59",
		  "RestakeDate": "2011/07/21 00:00:00",
		  "ExpirationDate": "2011/07/26 00:00:00",
		  "LPMeetingAcceptDueDate": "",
		  "OverheadBeginDate": "",
		  "OverheadEndDate": ""
	  },
	  "ServiceArea": {
		  "PrimaryServiceAreaCode": {
			  "SACode": "ZZGL103"
		  },
		  "AdditionalServiceAreaCodes": {
			  "SACode": [
				  "ZZL01",
				  "ZZL02",
				  "ZZL03"
			  ]
		  }
	  },
	  "Excavator": {
		  "CompanyName": "John Doe CONSTRUCTION",
		  "Address": "555 Some RD",
		  "City": "SOME PARK",
		  "State": "ZZ",
		  "Zip": "55555",
		  "Type": "Excavator",
		  "Contact": {
			  "Name": "Johnny Doe",
			  "Phone": "1115552345",
			  "Email": "example@example.com"
		  },
		  "FieldContact": {
			  "Name": "Field Contact",
			  "Phone": "1235557924",
			  "Email": "example@example.com"
		  },
		  "CrewOnsite": "true"
	  },
	  "ExcavationInfo": {
		  "TypeOfWork": "rpr man hole tops",
		  "WorkDoneFor": "gpc",
		  "ProjectDuration": "60 days",
		  "ProjectStartDate": "2011/07/08 07:00:00",
		  "Explosives": "No",
		  "UndergroundOverhead": "Underground",
		  "HorizontalBoring": "Road, Driveway, and Sidewalk",
		  "Whitelined": "No",
		  "LocateInstructions": "locate along the r/o/w on both sides of the rd - including the rd itself - from inter to inter ",
		  "Remarks": "Previous Request Number:05161-120-011 revious Request Number:06044-254-020 v revious Request Number:06171-300-030",
		  "DigsiteInfo": {
			  "LookupBy": "MANUAL",
			  "LocationType": "Multiple Address",
			  "Subdivision": "",
			  "AddressInfo": {
				  "State": "ST",
				  "County": "COUNTY",
				  "Place": "PLACE",
				  "Zip": "",
				  "Address": {
					  "AddressNum": [
						  "Address 1",
						  "Address 2"
					  ]
				  },
				  "Street": {
					  "Prefix": "",
					  "Name": "Trinity",
					  "Type": "Ave",
					  "Suffix": "SW"
				  }
			  },
			  "NearStreet": {
				  "State": "XX",
				  "County": "SomeCounty",
				  "Place": "City",
				  "Prefix": "",
				  "Name": "",
				  "Type": "",
				  "Suffix": ""
			  },
			  "Intersection": {
				  "ItoI": [{
						  "State": "XX",
						  "County": "FULERTON",
						  "Place": "NORCROSS",
						  "Prefix": "",
						  "Name": "London",
						  "Type": "St",
						  "Suffix": "SW"
					  },
					  {
						  "State": "ZZ",
						  "County": "COUNTY",
						  "Place": "ATLANTA",
						  "Prefix": "",
						  "Name": "Jefferson",
						  "Type": "Ave",
						  "Suffix": "SW"
					  }
				  ]
			  },
			  "WellKnownText": "POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295,-81.08858407706913 32.02259853170128,-81.05322183341679 32.02434500961698,-81.05047525138554 32.042681017283066,-81.0319358226746 32.06537765335268,-81.01202310294804 32.078469305179404,-81.02850259513554 32.07963291684719,-81.07759774894413 32.07090546831167,-81.12154306144413 32.08806865844325,-81.13390268058475 32.07206917625161))"
		  }
	  }
  }
  end

  describe "POST #create" do
    context "with valid params and new record" do
      it "Create a new Ticket" do
        expect {
          post :create, format: :json, params: ticket_params
        }.to change(Ticket, :count).by(1)
        expect(response).to have_http_status(201)
      end
    end
    context "with Invalid params" do
      it "Create fails with status unprocessable entity" do
        post :create, params: ticket_params.except(:RequestNumber), format: :json
        expect(response).to have_http_status(422)
        expect(json_response["message"]).to eq 'Could not able to create with the given params'
        expect(json_response["errors"].first).to eq "Request number can't be blank"
      end
    end
    context "with Invalid params" do
      it "Create fails with status unprocessable entity" do
        post :create, params: ticket_params.except(:RequestType), format: :json
        expect(response).to have_http_status(422)
        expect(json_response["message"]).to eq 'Could not able to create with the given params'
        expect(json_response["errors"].first).to eq "Request type can't be blank"
      end
    end
    context "with Invalid params" do
      it "Create fails with status unprocessable entity" do
        post :create, params: ticket_params.except(:Excavator), format: :json
        expect(response).to have_http_status(422)
        expect(json_response["message"]).to eq 'Could not able to create with the given params'
        expect(json_response["errors"].first).to eq "Company name can't be blank"
      end
    end
  end

  describe "GET #show_ticket" do
    it 'returns the ticket based on id with status 200' do
      get :show_ticket, params: { id: ticket.id }
      expect(response).to have_http_status(200)
      expect(json_response['ticket']['request_number']).to eq '234567'
      expect(json_response['ticket']['request_type']).to eq 'Normal'
      expect(json_response['excavator']['company_name']).to eq 'John Doe CONSTRUCTION'
    end
    it 'returns not found with status 404' do
      get :show_ticket, params: { id: 34567 }
      expect(response).to have_http_status(404)
      expect(json_response['message']).to eq 'Record Not Found'      
    end
  end

  describe "GET #show_tickets" do
    it 'returns all the tickets with status 200' do
      get :show_tickets
      expect(response).to have_http_status(200)
      expect(json_response[0]['ticket']['request_number']).to eq '234567'
      expect(json_response[0]['ticket']['request_type']).to eq 'Normal'
      expect(json_response[0]['excavator']['company_name']).to eq 'John Doe CONSTRUCTION'
    end
    it 'returns not found with status 404' do
      Ticket.destroy_all
      get :show_tickets
      expect(response).to have_http_status(404)
      expect(json_response['message']).to eq 'Records Not Found'      
    end
  end
end
