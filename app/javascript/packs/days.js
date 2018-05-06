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

  $('.search-bar input').on('keydown', (e) => {
    // 37 == left arrow, 39 == right arrow
    const { metaKey, keyCode, altKey, shiftKey } = e
    const leftArrow = keyCode == 37
    const rightArrow = keyCode == 39

    if (metaKey && leftArrow)   return back('year')
    if (metaKey && rightArrow)  return forward('year')
    if (altKey && leftArrow)    return back('month')
    if (altKey && rightArrow)   return forward('month')
    if (shiftKey && leftArrow)  return back('week')
    if (shiftKey && rightArrow) return forward('week')
    if (leftArrow)              return back('day')
    if (rightArrow)             return forward('day')
  });
})
