import React from "react"
import PropTypes, { array } from "prop-types"
import { Doughnut } from 'react-chartjs-2';

class DrowPieChart extends React.Component {
  render () {
    const expenses = this.props.expenses
    console.log(expenses)
    let labels = []
    const datasets = []

    for (let expense in expenses) {
      datasets.push(expenses[expense].expense)
      labels.push(expenses[expense].name)
    }
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
