import React from "react"
import PropTypes from "prop-types"
class SumOfExpenses extends React.Component {
  render () {
    const expenses = this.props.expenses
    let sum_expense = 0
    for (let expense in expenses) {
      sum_expense = sum_expense + expenses[expense].expense
    }
    sum_expense = (sum_expense.toString()).replace( /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,')
    return (
      <React.Fragment>
        ¥{sum_expense}
      </React.Fragment>
    );
  }
}

SumOfExpenses.propTypes = {
  expenses: PropTypes.array.isRequired
};
export default SumOfExpenses
