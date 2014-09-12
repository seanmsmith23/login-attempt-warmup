class Rack::Attack
  throttle("logins/email", :limit => 5, :period => 2.minutes) do |req|
    if req.path == '/login' && req.post?
      # return the email if present, nil otherwise
      req.params['email'].presence
    end
  end

end