$( function() {
    $('#expense_name').autocomplete({
        autoFocus: true,  //テキストフィールドの値をフォーカスされたアイテムの値で置き換える
        source: "/expenses/auto_complete.json",  //サジェストのデータを呼び出す
        minLength: 1  //オートコンプリートが動作する文字数を指定
    });
  });