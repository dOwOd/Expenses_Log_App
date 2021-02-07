// 下にスクロールした時にfooterを非表示にする
$(document).on('turbolinks:load', function () {    
    window.addEventListener('scroll', function(){

        if (window.matchMedia('(max-width: 768px)').matches) {
            if (window.scrollY > 30) {
                $('.button-list').css({
                    'opacity':'0'
                });
            }

            if (window.scrollY < 30) {
                $('.button-list').css({
                    'opacity':'1'
                });
            }
        }
    });
});