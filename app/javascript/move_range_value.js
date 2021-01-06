//初回読み込み、リロード、ページ切り替えで動く。
$(document).on('turbolinks:load', function() {
    $('.range-slider').on('input', '.slider-input', function() {
        $(this).parent().find('.slider-value').html (this.value + "%"); 
    });
 });