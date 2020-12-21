import React from "react"
import PropTypes from "prop-types"

let sum_expense = 0

class PerPersonExpenses extends React.Component {
  render () {
    const expenses = this.props.expenses
    const users = this.props.users
    let user_count = users.length
    let per_person = 0
    sum_expense = 0
    if (expenses.length) {
      for (let expense in expenses) {
        sum_expense = sum_expense + expenses[expense].expense
      }
      per_person = sum_expense / user_count
    }
    return (
      <React.Fragment>
        ¥{per_person}
      </React.Fragment>
    );
  }
}

PerPersonExpenses.propTypes = {
  expenses: PropTypes.array.isRequired,
  users: PropTypes.array.isRequired,
};
export default PerPersonExpenses
