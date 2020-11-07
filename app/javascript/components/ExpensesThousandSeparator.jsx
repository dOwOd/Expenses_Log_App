import React from "react"
import PropTypes from "prop-types"
class ExpensesThousandSeparator extends React.Component {
  render () {
    return (
      <React.Fragment>
        ExpensesThousandSeparator: {this.props.greeting}
      </React.Fragment>
    );
  }
}

ExpensesThousandSeparator.propTypes = {
  greeting: PropTypes.string
};
export default ExpensesThousandSeparator
