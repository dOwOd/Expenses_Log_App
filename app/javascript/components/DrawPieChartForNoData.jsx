import React from "react"
import PropTypes, { array } from "prop-types"
import { Doughnut } from 'react-chartjs-2'

class DrawPieChartForNoData extends React.Component {
  render () {
    let labels = []
    const datasets = []

    datasets.push(100)
    
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
    // console.log(graphOption)
    return (
      <div className="DrawPieChartForNoData">
        {/* グラフコンポーネントの呼び出し */}
        <Doughnut
          data={graphData} 
          />
      </div>
    );
  }
}

export default DrawPieChartForNoData