module RequestSpecHelper
  #Parse json response to ruby hash
 def json
   JSON.parse(response.body)
 end
end
