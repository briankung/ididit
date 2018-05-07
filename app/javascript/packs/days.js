import debounce from 'lodash-es/debounce'

const dateParam = window.location.toString().match(/\d{4}-\d{2}-\d{2}/)[0]
const dateFormat = 'YYYY-MM-DD';
const date = moment(dateParam);

const changeDate = (targetDate) => {
  window.location = window.location.toString().replace(dateParam, targetDate)
}

const back = (timeUnit) => {
  const newDate = date.subtract(1, timeUnit).format(dateFormat)
  return changeDate(newDate)
}

const forward = (timeUnit) => {
  const newDate = date.add(1, timeUnit).format(dateFormat)
  return changeDate(newDate)
}

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

  $('.search-bar input').on('keydown', (event) => {
    const { metaKey: cmdKey, keyCode, altKey, shiftKey } = event,
          leftArrow = keyCode == 37,
          rightArrow = keyCode == 39,
          cmdLeft = cmdKey && leftArrow,
          cmdRight = cmdKey && rightArrow,
          altLeft = altKey && leftArrow,
          altRight = altKey && rightArrow,
          shiftLeft = shiftKey && leftArrow,
          shiftRight = shiftKey && rightArrow

    if (cmdLeft)    return back('year')
    if (cmdRight)   return forward('year')
    if (altLeft)    return back('month')
    if (altRight)   return forward('month')
    if (shiftLeft)  return back('week')
    if (shiftRight) return forward('week')
    if (leftArrow)  return back('day')
    if (rightArrow) return forward('day')
  });
})
