options = rejectUnauthorized: false

module.exports =
  ping: (robot, towerUrl, towerUser, towerPassword, callback) ->
    url = towerUrl + "/ping/"
    auth = 'Basic ' + new Buffer(towerUser + ':' + towerPassword).toString('base64');
    console.info "Going to URL == #{url}"
    robot.http(url, options).headers(Authorization: auth, Accept: 'application/json').get() (error, response, body) ->
      if error
        callback "error!"
      if response.statusCode is 200
        data = null
        try
          data = JSON.parse body
          console.log "role = #{data.role} and version = #{data.version}"
          callback "role = #{data.role} and version = #{data.version}"
        catch e
          callback "exception! #{e}"
      else
        callback "something bad happened #{response.statusCode}"

  inventories: (robot, towerUrl, towerUser, towerPassword, callback) ->
    url = towerUrl + "/inventories/"
    auth = 'Basic ' + new Buffer(towerUser + ':' + towerPassword).toString('base64');
    console.info "Going to URL == #{url}"
    robot.http(url, options).headers(Authorization: auth).get() (error, response, body) ->
      if error
        callback "error!"
      if response.statusCode is 200
        data = null
        try
          data = JSON.parse body
          count = data.count
          msg = "there are #{count} inventory items.<p>"
          if count > 0
            for result in data.results
              msg += "[#{result.id}] #{result.name}<p>"
            callback msg
          else
            callback "there a no items currently in your inventory"
        catch e
          callback "exception! #{e}"
      else
        callback "something bad happened #{response.statusCode}"

  inventory: (robot, towerUrl, towerUser, towerPassword, subcommand, callback) ->
    url = towerUrl + "/inventories/#{subcommand}/"
    auth = 'Basic ' + new Buffer(towerUser + ':' + towerPassword).toString('base64');
    console.info "Going to URL == #{url}"
    robot.http(url, options).headers(Authorization: auth).get() (error, response, body) ->
      if error
        callback "error!"
      if response.statusCode is 200
        data = null
        try
          data = JSON.parse body
          msg = "name: #{data.name}, total hosts: #{data.total_hosts}, failures: #{data.hosts_with_active_failures}"
          callback msg
        catch e
          callback "exception! #{e}"
      else
        callback "something bad happened #{response.statusCode}"
