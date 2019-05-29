class API::BaseController < ActionController::API

  protected
  def index_json(objects)
    objects.map do |object|
      individual_json(object)
	  end
  end

  def individual_json(object)
    { ticket: json_object(object), excavator: json_object(object.excavator) }
  end

  def json_object(object)
	  object.as_json.except('updated_at', 'created_at')
  end
end