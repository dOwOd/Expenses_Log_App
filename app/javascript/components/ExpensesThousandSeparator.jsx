import React from "react"
import PropTypes from "prop-types"
class ExpensesThousandSeparator extends React.Component {
  render () {
    return (
        <React.Fragment>
            ¥{(this.props.expense).replace( /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,')}
        </React.Fragment>
      );
  }
}

ExpensesThousandSeparator.propTypes = {
  expense: PropTypes.string
};
export default ExpensesThousandSeparator
