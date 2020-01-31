module TripsHelper
  def icon_color status
    case status
    when 'CREATED'
      'teal'
    when 'STARTED'
      'green'
    when 'CANCELLED'
      'grey'
    end
  end
end
