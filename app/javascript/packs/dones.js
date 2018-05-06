$(document).ready(() => {
  const date = $('#done_created_at').val();
  const dateText = window.localStorage.getItem(date);

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
});
