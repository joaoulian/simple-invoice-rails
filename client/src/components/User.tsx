import React from 'react';
import Image from 'next/image'
import { Account } from 'services/GitHubTypes';

export const User = (props: UserProps) => {
  const { user } = props;
  
  return (
    <div className="py-8 px-8 max-w-sm mx-auto bg-white rounded-xl shadow-lg space-y-2 sm:py-4 sm:flex sm:items-center sm:space-y-0 sm:space-x-6">
      <div className="text-center space-y-2 sm:text-left">
        <div className="space-y-0.5">
          <p className="text-lg text-black font-semibold">
            {user.name}
          </p>
          <p className="text-slate-500 font-medium">
            {user.url}
          </p>
        </div>
        <button className="px-4 py-1 text-sm text-purple-600 font-semibold rounded-full border border-purple-200 hover:text-white hover:bg-purple-600 hover:border-transparent focus:outline-none focus:ring-2 focus:ring-purple-600 focus:ring-offset-2">{user.followers}</button>
      </div>
    </div>
  )
}

interface UserProps {
  user: Account
}