# Description
#   ansible hubot chatops
#
# Configuration:
#   HUBOT_TOWER_URL
#   HUBOT_TOWER_USER_NAME
#   HUBOT_TOWER_PASSWORD
#   HUBOT_TOWER_ROOM
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Lee Faus <leefaus@github.com>

url = require('url')
querystring = require('querystring')
commands = require('./tower/commands')
towerUrl = process.env.HUBOT_TOWER_URL or "https://tower.gitaboard.com"
towerUser = process.env.HUBOT_TOWER_USER_NAME or "hubot"
towerPassword = process.env.HUBOT_TOWER_PASSWORD or "Passw0rd"
room = process.env.HUBOT_TOWER_ROOM or "GENERAL"

towerUrl += "/api/v1"

module.exports = (robot) ->
  robot.hear /tower (\S+) (\S+)/, (msg) ->
    commands[msg.match[1]] robot, towerUrl, towerUser, towerPassword, msg.match[2], (what) ->
      robot.messageRoom room, what

  robot.hear /tower (\S+)$/, (msg) ->
    commands[msg.match[1]] robot, towerUrl, towerUser, towerPassword, (what) ->
      robot.messageRoom room, what
