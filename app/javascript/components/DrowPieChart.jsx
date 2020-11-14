import React from "react"
import PropTypes, { array } from "prop-types"
import { Doughnut } from 'react-chartjs-2';

class DrowPieChart extends React.Component {
  render () {
    const expenses = this.props.expenses
    let labels = []
    const datasets = []
    let sum_expense = 0

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
          data: datasets,
          backgroundColor: 'rgba(130, 144, 255, 1)',
        },
      ],
    };
    return (
      <div className="DrowPieChart">
        <h2>¥{sum_expense}</h2>
        {/* グラフコンポーネントの呼び出し */}
        <Doughnut data={graphData}/>
      </div>
    );
  }
}

DrowPieChart.propTypes = {
  expenses: PropTypes.array.isRequired
};
export default DrowPieChart
