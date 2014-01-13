_      = require 'underscore'
assert = require 'assert'
quest  = require 'quest'
app    = require '../'

SOURCE_HOST = '42foo.com'
{PORT, TARGET_HOST} = process.env

paths = [
  name: 'no path'
  path: '/'
,
  name: 'a path'
  path: '/path'
,
  name: 'a path and query parameters'
  path: '/path?some_key=some_val&some_other_key=some_other_val'
]

describe 'redirector', ->
  _(['', 'www.', 'support.']).each (subdomain) ->
    describe "with subdomain #{subdomain}", ->
      _(paths).each ({name, path}) ->
        it "redirects http properly with #{name}", (done) ->
          opts =
            uri: "http://localhost:#{PORT}#{path}"
            headers:
              host: subdomain + TARGET_HOST
            followRedirects: false
          quest opts, (err, resp, body) ->
            assert.ifError err
            assert.equal resp.statusCode, 301
            assert.equal resp.headers.location, "http://#{subdomain}#{TARGET_HOST}#{path}"
            done()

        it "redirects https properly with #{name}", (done) ->
          opts =
            uri: "http://localhost:#{PORT}#{path}"
            headers:
              host: subdomain + TARGET_HOST
              'x-forwarded-proto': 'https'
            followRedirects: false
          quest opts, (err, resp, body) ->
            assert.ifError err
            assert.equal resp.statusCode, 301
            assert.equal resp.headers.location, "https://#{subdomain}#{TARGET_HOST}#{path}"
            done()
