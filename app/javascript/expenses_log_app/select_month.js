import React from 'react';
import ReactDOM from 'react-dom';
import { css } from '@emotion/css'; 

const selectMonthStyle = css({
    display: 'inline',
  });

document.addEventListener('DOMContentLoaded', () => {
    let date = {
        selectDate: new Date()
    };

    let selectYear = date.selectDate.getFullYear();
    let selectMonth = date.selectDate.getMonth() + 1;

    const element = <React.Fragment>
                        <button type="button">＜</button>
                        <h1 className={selectMonthStyle}> {selectYear}年{selectMonth}月 </h1>
                        <button type="button" className={selectMonthStyle}>＞</button>
                    </React.Fragment>;
    

    ReactDOM.render(element, document.getElementById('month'));
    // ReactDOM.render(
    //     React.createElement('div', null, 'select_month!'),
    //     document.body.appendChild(document.createElement('div')),
    // );
});