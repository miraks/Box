window.box = {}

onLoad = (callback, turbolinksOnly = false) ->
  document.addEventListener 'DOMContentLoaded', callback unless turbolinksOnly
  document.addEventListener 'page:load', callback

# Инициализация ангуляра после загрузки страницы
bootstrapAngular = ->
  apps = document.querySelectorAll '[ng-app]'
  for app in apps
    module = app.getAttribute 'ng-app'
    angular.bootstrap app, [module]

onLoad bootstrapAngular, true

# Эмуляция рельсового method для ссылок
# Обрабатывает только редиректы, любые другие ответы от сервера игнорируются
useDataMethod = ->
  document.body.addEventListener 'click', (event) ->
    target = event.target
    method = target.getAttribute 'data-method'
    return true unless target.tagName == 'A' and method?

    event.preventDefault()

    form = document.createElement 'form'
    form.method = if method == 'get' then 'get' else 'post'
    form.action = target.href

    csrf_token = document.querySelector('meta[name=csrf-token]').content
    params = { '_method': method, 'authenticity_token': csrf_token }

    Object.each params, (key, value) ->
      hiddenField = document.createElement 'input'
      hiddenField.type = 'hidden'
      hiddenField.name = key
      hiddenField.value = value
      form.appendChild hiddenField

    document.body.appendChild form
    form.submit()
    # That's all, who needs jquery?

onLoad useDataMethod