export const Breadcrumbs = (props: BreadcrumbsProps) => {
  return (
    <div className="text-sm breadcrumbs">
      <ul>
        {props.list.map((item, key) => (
          <li key={`breadcrumbs-${key}`}><a href={item.href}>{item.label}</a></li>
        ))}
      </ul>
    </div>
  )
}

export interface BreadcrumbsProps {
  list: {
    label: string,
    href: string
  }[]
}