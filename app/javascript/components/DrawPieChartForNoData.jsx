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
        responsive: false,
        animation:{
            animateRotate: false,
            animateScale: true
        }
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

Chart.pluginService.register({
    beforeDraw: function(chart) {
      var width = chart.chart.width,
          height = chart.chart.height,
          ctx = chart.chart.ctx;
  
      ctx.restore();
      var fontSize = (height / 300).toFixed(2);
      ctx.font = fontSize + "em sans-serif";
      ctx.textBaseline = "middle";
  
      var text = "¥" + 0,
          textX = Math.round((width - ctx.measureText(text).width) / 2),
          textY = height / 1.975;
  
      ctx.fillText(text, textX, textY);
      ctx.save();
    }
  });