import React from "react";
import { Toaster } from "../ui/sonner";

export function Layout({ children }: React.PropsWithChildren) {
  return (
    <div className="container mx-auto p-4">
      {children}
      <Toaster />
    </div>
  );
}
