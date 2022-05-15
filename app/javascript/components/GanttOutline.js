import React from "react";
import Gantt from  "./Gantt";
import GanttForm from "./GanttForm";

export default function GanttOutline(props) {
  console.log(props.mission)
  return (
    <div className='gt-flex-viewport'>
      <div className='gt-flex-form'>
        <GanttForm />
      </div>
      <div className='gt gt-flex-gantt'>
        <Gantt mission={props.mission} />
      </div>
    </div>
  );
}
