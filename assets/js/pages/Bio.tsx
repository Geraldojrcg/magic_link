import { BioLinkPreview } from "@/components/domain/bio-link-preview";
import { BioLink } from "@/types";
import React from "react";

type BioPageProps = {
  bio_link: BioLink;
};

export default function Bio({ bio_link }: BioPageProps) {
  console.log(bio_link);

  return (
    <div className="w-full p-0 md:p-8 md:px-32 lg:px-96">
      <BioLinkPreview bioLink={bio_link} />
    </div>
  );
}
