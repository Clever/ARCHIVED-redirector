# Notice

_ARCHIVED: This repo is no longer maintained by Clever._

redirector
==========

`redirector` is a simple app that redirects all requests to a target domain, preserving the original
request's protocol, subdomain, path, and querystring.

For instance, a request to `https://sub.source_host.com/path?query_key=query_val` would be
redirected to `https://sub.target_host.com/path?query_key=query_val`.

The target host is determined based on the `TARGET_HOST` environment variable.
