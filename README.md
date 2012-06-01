silentcrash
===========

Passing a variable string to NSURL causes crash when being used in a dispatch queue

I've also tried pulling out the RAII and assigned it a local variable which
seems to point to the NSURL creation as the culprit.

  url_object = NSURL.URLWithString(google)
  p url_object
  data = NSData.alloc.initWithContentsOfURL(url_object)

This will never pring the url_object when called from within a dispatch queue
