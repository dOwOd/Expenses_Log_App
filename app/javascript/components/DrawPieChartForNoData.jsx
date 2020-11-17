import React from "react"
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

    const graphOption = {
        tooltips: {
            enabled: false
        }
      }
    return (
      <div className="DrawPieChartForNoData">
        {/* グラフコンポーネントの呼び出し */}
        <Doughnut
          data={graphData} 
          options={graphOption}
          />
      </div>
    );
  }
}

export default DrawPieChartForNoData