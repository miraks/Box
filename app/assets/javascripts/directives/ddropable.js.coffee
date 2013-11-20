angular.module('BoxApp').directive 'ddropable', ['$rootScope', 'UUID', 'Storage', ($rootScope, UUID, Storage) ->
  restrict: 'A'
  scope:
    item: '=ddropable'
    onDrop: '=onDrop'
  link: (scope, element, attrs) ->
    storage = Storage.get 'dragAndDrop', {}

    uuid = element.data 'uuid'
    unless uuid?
      uuid = UUID.generate()
      element.data 'uuid', uuid

    element.bind 'dragover', (event) ->
      event.preventDefault()
      event.stopPropagation()

      event.dataTransfer.dropEffect = 'move'

    element.bind 'dragenter', (event) ->
      angular.element(event.target).addClass 'drag-over'

    element.bind 'dragleave', (event) ->
      angular.element(event.target).removeClass 'drag-over'

    element.bind 'drop', (event) ->
      event.preventDefault()
      event.stopPropagation()

      srcUuid = event.dataTransfer.getData 'uuid'
      scope.onDrop? storage[srcUuid], scope.item

    $rootScope.$on 'dragstart', ->
      element.addClass 'drag-target'

    $rootScope.$on 'dragend', ->
      element.removeClass 'drag-target'
      element.removeClass 'drag-over'
]