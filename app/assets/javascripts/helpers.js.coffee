# Эмуляция рельсового method для ссылок
# Обрабатывает только редиректы, любые другие ответы от сервера игнорируются
# TODO: Написать хак для IE для работы с dataset (Element.prototype?)
document.body.addEventListener 'click', (event) ->
  target = event.target
  method = target.dataset.method
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