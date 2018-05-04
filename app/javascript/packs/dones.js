const paramPattern = /q=([^?&]+)/i;
const params = window.location.search;
// const paramValue = paramPattern.exec(params)[1];
const dateParam = window.location.toString().match(/\d{4}-\d{2}-\d{2}/)[0]
const dateFormat = 'YYYY-MM-DD';
const date = moment(dateParam);
const { addTime: add, subtractTime: subtract } = date
const paramIsDate = Boolean(date);
const paramDate = date.format(dateFormat);

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

$(document).ready(() => {
  const date = $('#done_created_at').val();
  const dateText = window.localStorage.getItem(date);

  $('.editable-entry').on('click', () => {
    this.style.setProperty('display', 'none')
    const form = $($(this).siblings('form.edit_done')[0])
    form.css('display', 'inline')
  });

  $('form.edit_done').on('keyup', (e) => {
    if (e.keyCode === 27) {
      const form = $(this).closest('form');
      form.css('display', 'none')
      entry = form.siblings('.editable-entry')[0]
      entry.style.setProperty('display', 'inline')
    }
  });

  $('form.new_done textarea#done_text').on('keydown', (e) => {
    if (e.metaKey && e.keyCode == 13) {
      $(this).closest('form').submit();
    } else if ((e.shiftKey && e.keyCode == 191) || (e.keyCode == 84)) {
      e.stopPropagation();
    };
  });

  $('form.new_done').on('submit', (e) => {
    window.localStorage.removeItem(date);
  });

  $('form.new_done textarea#done_text').val(dateText);

  $('form.new_done textarea#done_text').on('input', (e) => {
    window.localStorage.setItem(date, $(e.target).val());
  });

  // This stuff was on dones/index.html.erb

  $('.search-bar input').focus();

  if (paramIsDate) {
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
  }
});
