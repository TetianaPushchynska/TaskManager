// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails'
import 'controllers'
import 'jquery'

$(document).on('click', 'button.close', function() {
  $(this).closest('.alert').fadeOut();
});

document.addEventListener('click', function(event) {
  if (!event.target.matches('.custom-select')) {
    const customSelectContainers = document.querySelectorAll('.custom-select-container');
    customSelectContainers.forEach(function(container) {
      container.classList.remove('open');
    });
  }
});

document.querySelectorAll('.custom-select').forEach(function(select) {
  select.addEventListener('click', function(event) {
    const container = event.target.closest('.custom-select-container');
    container.classList.toggle('open');
  });
});
