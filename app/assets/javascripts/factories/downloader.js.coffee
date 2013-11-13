angular.module('BoxApp').factory 'Downloader', [ ->
  download: (url) ->
    form = document.createElement 'form'
    form.method = 'get'
    form.action = url
    document.body.appendChild form
    form.submit()
]