angular.module('BoxApp').factory 'Downloader', [ ->
  Downloader =
    download: (url) ->
      # TODO: maybe there is better way
      frame = document.createElement 'iframe'
      frame.src = url
      frame.style.display = 'none'
      document.body.appendChild(frame)
]