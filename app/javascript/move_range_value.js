//初回読み込み、リロード、ページ切り替えで動く。
$(document).on('turbolinks:load', function () {    
    
    // レンジスライダーの値を動的に変更させる
    $('.range-slider').on('input', '.slider-input', function () {
        $(this).parent().find('.slider-value').html(this.value + "%");
    });

    // レンジスライダーの値の合計を動的に変更させる
    $('.range-slider').on('input', '.slider-input', function () {
    var sum = 0;
        $(".slider-input").each(function () {
            sum += +$(this).val();
        });
        $('.sum_value').html(`${sum}%`).css("font-size", "130%")
        if (sum > 100) {
            $('.sum_value').css("color", '#E87A90')
        }
        if (sum == 100) {
            $('.sum_value').css("color", 'black')
        }
        if (sum < 100) {
            $('.sum_value').css("color", '#7DB9DE')
        }
    });
});