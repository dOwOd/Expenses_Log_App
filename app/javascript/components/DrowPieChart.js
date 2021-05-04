import React from "react"
import PropTypes, { array } from "prop-types"
import { Doughnut } from 'react-chartjs-2'
import 'chartjs-plugin-colorschemes'

let sum_expense = 0

class DrowPieChart extends React.Component {
  render () {
    const expenses = this.props.expenses
    let labels = []
    let datasets = []
    sum_expense = 0
    let canvasWidth = 650
    let convasHeight = 650 
    if (window.matchMedia('(max-width: 768px)').matches) {
      // モバイル時用処理
      canvasWidth = window.parent.screen.width * 0.85
      convasHeight = window.parent.screen.width * 0.85
    }
    let graphData
    let graphOption

    if (expenses.length) {
      for (let expense in expenses) {
        datasets.push(expenses[expense].expense)
        labels.push(expenses[expense].name)
        sum_expense = sum_expense + expenses[expense].expense
      }
    }
    if (sum_expense > 0) {
      /** グラフデータ */
      graphData = {
        // 軸ラベル
        labels
        ,
        datasets: [
          // 表示するデータセット
          {
            data: datasets
          },
        ],
      };
  
      graphOption = {
        plugins: {
          colorschemes: {
            scheme: 'tableau.HueCircle19'
          }
        },
        maintainAspectRatio: false,
        responsive: false,
        legend: {
          display: false,
        },
        tooltips: {
          mode: "label",
          callbacks: {
            label: function (tooltipItem, data) {
              let percent_sum_expense = sum_expense.replace(',', '')
              let percent = (data.datasets[0].data[tooltipItem.index] / percent_sum_expense) * 100
              return data.labels[tooltipItem.index] + ': ' + Math.round(percent) + '%'
            }
          }
        }
      }
    } else {
      datasets = []
      datasets.push(100)
      /** グラフデータ */
      graphData = {
        // 軸ラベル
        labels
        ,
        datasets: [
          // 表示するデータセット
          {
            data: datasets
          },
        ],
      };

      graphOption = {
        tooltips: {
          enabled: false
        },
        legend: {
          display: false,
        },
        
        maintainAspectRatio: false,
        responsive: false,
        animation: {
          animateRotate: false,
          animateScale: true
        }
      }
    }

    sum_expense = (sum_expense.toString()).replace( /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,')
    
    return (
      <div className="DrowPieChart">
        {/* グラフコンポーネントの呼び出し */}
        <Doughnut
          data={graphData} 
          options={graphOption}
          width={canvasWidth}
          height={convasHeight}
          margin='auto'
          />
      </div>
    );
  }
}

DrowPieChart.propTypes = {
  expenses: PropTypes.array.isRequired,
}
export default DrowPieChart

Chart.pluginService.register({
  beforeDraw: function(chart) {
    var width = chart.chart.width,
        height = chart.chart.height,
        ctx = chart.chart.ctx;

    ctx.restore()

    var fontSize = 0

    // ホントは画面サイズによって柔軟にフォントサイズを変えたい，，，
    if (window.matchMedia('(max-width: 767px)').matches) {
      // モバイル時用処理
      fontSize = (height / 225).toFixed(2)
    } else{
      fontSize = (height / 300).toFixed(2)
    }

    ctx.font = fontSize + "em sans-serif"
    ctx.textBaseline = "middle"

    var text = "¥" + sum_expense,
        textX = Math.round((width - ctx.measureText(text).width) / 2),
        textY = height / 2

    ctx.fillText(text, textX, textY)
    ctx.save()
  }
})