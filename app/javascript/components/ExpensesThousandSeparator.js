import React from "react"
import PropTypes from "prop-types"
class ExpensesThousandSeparator extends React.Component {
  render () {
    return (
      <div>
        <h4 className="mt-1 mb-0">
          ¥{(this.props.expense).replace( /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,')}          
        </h4>
      </div>
      );
  }
}

ExpensesThousandSeparator.propTypes = {
  expense: PropTypes.string
};
export default ExpensesThousandSeparator
