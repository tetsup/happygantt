import React from "react"
import PropTypes from "prop-types"

export default function Gantt(props) {
  return (
    <React.Fragment>
      {props.data[0]}
    </React.Fragment>
  );
}

Gantt.propTypes = {
  greeting: PropTypes.string
};
