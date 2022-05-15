import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';
import momentPropTypes from 'react-moment-proptypes';

export default function GanttDateScale(props){
  return (
    <div className='gt gt-header gt-z-10 gt-right-flex'>
      <GanttDateScaleWeekly props={props} />
    </div>
  );
}

function GanttDateScaleWeekly(props){
  let months = create_month_array('2021-01-01', '2022-12-31');
  return months.map(month => {
    return (
      <div className='gt gt-right-header-part gt-primary gt-border-bottom gt-border-right' style={{flex: month.length}} key={month.text}>
        {month.text}
      </div>
    );
  });
}

function create_month_array(date_from, date_to){
  let res = [];
  for(let month = moment(date_from, 'YYYY-MM-DD').startOf('month').clone(); month.isBefore(moment(date_to, 'YYYY-MM-DD')); month.add(1, 'months')){
    res.push({text: month.format('YYYY-MM'), length: month.daysInMonth()});
  }
  return res;
}
//GanttDateScale.propTypes = {
//  date_from: momentPropTypes.momentString,
//  date_to: momentPropTypes.momentString,
//  scale_size: PropTypes.oneOf(['weekly', 'monthly', 'quarterly'])
//};
