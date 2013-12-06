angular.module('BoxApp').factory 'ExtensionIcon', ['RailsResource', '$http', (RailsResource, $http) ->
  class ExtensionIcon extends RailsResource
    @configure
      url: '/api/v1/administration/extension_icons/{{extension}}'
      name: 'extension_icon'
      pluralName: 'extension_icons'

    create: ->
      # TODO: этот ужасный хак нужен для отправки файла
      #       при переписывание RailsResource нужно обязательно
      #       предусмотреть возможность послать файл
      data = @constructor.transformData @, {}
      data.extension_icon.icon = @icon

      transformer = (data, headersGetter) =>
        headers = headersGetter()
        headers["Content-Type"] = undefined
        formData = new FormData
        Object.each data.extension_icon, (key, value) =>
          formData.append "extension_icon[#{key}]", value
        formData

      config = angular.extend { method: 'post', url: @$url().replace(@extension, ''), data: data, transformRequest: transformer }, @constructor.getHttpConfig()
      @processResponse $http(config)

    equal: (other) ->
      @extension? and other.extension? and @extension == other.extension
]