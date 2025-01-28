import React from "react";

export function Layout({ children }: React.PropsWithChildren) {
  return <div className="container mx-auto p-4">{children}</div>;
}
