import debounce from 'lodash-es/debounce'

$(document).ready(function() {
  $('#dones').on('input', debounce(
    () => {
      const { 0: { action: donesUrl }, 0: dones } = $('.dones-form')
      const serialized = $(dones).serialize()

      $.ajax(
        donesUrl,
        {
          method: 'post',
          data: serialized,
          dataType: 'json'
        }
      ).then(data => console.log(data))
    },
    500
  ))
})
