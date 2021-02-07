// 下にスクロールした時にfooterを非表示にする
$(document).on('turbolinks:load', function () {    
    window.addEventListener('scroll', function(){

        if (window.scrollY > 30) {
            $('.footer').css({
                'opacity':'0'
            });
        }

        if (window.scrollY < 30) {
            $('.footer').css({
                'opacity':'1'
            });
        }
    });
});