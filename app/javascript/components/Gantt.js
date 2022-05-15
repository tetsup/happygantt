import React from 'react';
import GanttDateScale from './GanttDateScale';
import GanttElement from './GanttElement';

export default function Gantt(props){
  console.log(props.mission)
  return (
    <div className='gt gt-scroll'>
      <div className='gt gt-left-part'>
        <div className='gt gt-viewport'>
          <div className='gt gt-header gt-z-11 gt-primary gt-border-bottom gt-border-right' />
          <div className='gt gt-left-scrollarea'>
            {props.mission.projects.map((project) => (
              <div className='gt gt-element gt-index gt-background gt-border-bottom gt-border-right' key={project.id}>
                {project.name}
              </div>
            ))}
          </div>
        </div>
      </div>
      <div className='gt gt-right-part'>
        <div className='gt gt-viewport'>
          <GanttDateScale />
          <div className='gt gt-scrollarea'>
            {props.mission.projects.map((project) => (
              <GanttElement />
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
