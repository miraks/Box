angular.module('BoxApp').directive 'ddragable', ['$rootScope', 'UUID', 'Storage', ($rootScope, UUID, Storage) ->
  restrict: 'A'
  scope:
    item: '=ddragable'
  link: (scope, element, attrs) ->
    storage = Storage.get 'dragAndDrop', {}

    element.attr 'draggable', 'true'

    uuid = element.data 'uuid'
    unless uuid?
      uuid = UUID.generate()
      element.data 'uuid', uuid
      storage[uuid] = scope.item

    element.bind 'dragstart', (event) ->
      event.dataTransfer.setData 'uuid', uuid

      $rootScope.$emit 'dragstart'

    element.bind 'dragend', (event) ->
      $rootScope.$emit 'dragend'
]