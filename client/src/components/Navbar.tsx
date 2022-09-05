export const Navbar = (props: NavbarProps) => {
  return (
    <div className="navbar bg-base-100">
      <div className="flex-1">
        <a className="btn btn-ghost normal-case text-xl">Hello {props.email}</a>
      </div>
      <div className="flex-none">
        <ul className="menu menu-horizontal p-0">
          <li><a onClick={props.createInvoiceCallback}>Create invoice</a></li>
          <li><a onClick={props.logoutCallback}>Logout</a></li>
        </ul>
      </div>
    </div>
  )
}

export interface NavbarProps {
  email: string;
  createInvoiceCallback: () => void;
  logoutCallback: () => void;
}