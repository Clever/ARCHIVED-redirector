_    = require 'underscore'
http = require 'http'
url  = require 'url'

{PORT} = process.env

subdomain_from_host = (host='') ->
  host_parts = host.split '.'
  if host_parts.length is 3 then "#{host_parts[0]}." else ''

server = http.createServer (req, res) ->
  subdomain = subdomain_from_host req.headers.host
  [pathname, search] = req.url.split '?'
  new_url = url.format _({pathname, search}).extend
    protocol: 'http'
    host: subdomain + process.env.TARGET_HOST
  res.writeHead 301, location: new_url
  res.end()

server.listen PORT, ->
  console.log "redirector listening on port #{PORT}"
