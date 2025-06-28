import { BioLinkForm } from "@/types";
import React from "react";

type BioLinkPreviewProps = {
  bioLink: BioLinkForm;
};

export function BioLinkPreview({ bioLink }: BioLinkPreviewProps) {
  return (
    <div className="border rounded-lg p-4 space-y-4">
      {bioLink.banner && (
        <img
          src={bioLink.banner || "/placeholder.svg"}
          alt="Banner"
          className="w-full object-cover rounded-lg"
        />
      )}
      <h2 className="text-2xl font-bold">{bioLink.title || "Seu Título"}</h2>
      <p className="text-gray-600">
        {bioLink.description ?? "Sua descrição aparecerá aqui"}
      </p>
      <div className="space-y-2">
        {bioLink.external_links.map((link) => (
          <a
            key={link.id}
            href={link.url}
            target="_blank"
            rel="noopener noreferrer"
            className="block w-full text-center py-2 px-4 bg-blue-500 text-white rounded hover:bg-blue-600 transition-colors"
          >
            {link.title || "Link Pessoal"}
          </a>
        ))}
      </div>
    </div>
  );
}
