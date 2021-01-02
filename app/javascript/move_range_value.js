$(function() {
    $('.range-slider').on('input', '.slider-input', function() {
        　let val = $(this).val();
            $(this).parent().find('.slider-value').html (this.value + "%"); 
    });
});