import React from "react"
import PropTypes, { array } from "prop-types"
import { Doughnut } from 'react-chartjs-2'
import 'chartjs-plugin-colorschemes'

let sum_expense = 0

class DrowPieChart extends React.Component {
  render () {
    const expenses = this.props.expenses
    let labels = []
    const datasets = []
    sum_expense = 0
    const canvasWidth = 650
    const convasHeight = 650

    for (let expense in expenses) {
      datasets.push(expenses[expense].expense)
      labels.push(expenses[expense].name)
      sum_expense = sum_expense + expenses[expense].expense
    }
    sum_expense = (sum_expense.toString()).replace( /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,')
    
    /** グラフデータ */
    const graphData = {
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

    const graphOption = {
      plugins: {
        colorschemes: {
          scheme: 'tableau.HueCircle19'
        }
      },
      maintainAspectRatio: false,
      responsive: false,
    }
    return (
      <div className="DrowPieChart">
        {/* グラフコンポーネントの呼び出し */}
        <Doughnut
          data={graphData} 
          options={graphOption}
          width={canvasWidth}
          height={convasHeight}
          />
      </div>
    );
  }
}

DrowPieChart.propTypes = {
  expenses: PropTypes.array.isRequired,
};
export default DrowPieChart

Chart.pluginService.register({
  beforeDraw: function(chart) {
    var width = chart.chart.width,
        height = chart.chart.height,
        ctx = chart.chart.ctx;

    ctx.restore();
    var fontSize = (height / 300).toFixed(2);
    ctx.font = fontSize + "em sans-serif";
    ctx.textBaseline = "middle";

    var text = "¥" + sum_expense,
        textX = Math.round((width - ctx.measureText(text).width) / 2),
        textY = height / 1.875;

    ctx.fillText(text, textX, textY);
    ctx.save();
  }
});