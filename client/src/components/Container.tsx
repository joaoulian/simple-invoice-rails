import React, { ReactNode } from 'react';

export const Container = (props: { children: ReactNode }) => {
  return (
    <div className="p-0 m-0 font-inter h-screen min-h-screen">
      <div className="bg-slate-100 p-4 md:p-16">
        {props.children}
      </div>
    </div>
  )
}