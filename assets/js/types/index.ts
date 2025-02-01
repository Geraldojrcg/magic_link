export type Link = {
  id: string;
  original_url: string;
  short_url: string;
  visit_count: number;
  inserted_at: string;
}

export type ExternalLink = {
  id: string;
  title: string;
  url: string;
  bio_link_id: string;
}

export type BioLink = {
  title: string;
  description?: string;
  banner?: string;
  external_links: ExternalLink[];
}