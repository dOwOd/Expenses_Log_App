import React from "react"
import { Doughnut } from 'react-chartjs-2'

class DrawPieChartForNoData extends React.Component {
  render () {
    let labels = []
    const datasets = []
    const canvasWidth = 650
    const convasHeight = 650

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
        },
        maintainAspectRatio: false,
        responsive: false
      }
    return (
      <div className="DrawPieChartForNoData">
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

export default DrawPieChartForNoData