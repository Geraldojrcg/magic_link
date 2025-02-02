"use client";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { BioLinkGenerator } from "@/components/domain/bio-link-generator";
import { Layout } from "@/components/core/layout";
import { Deferred, useForm } from "@inertiajs/react";
import { Loader2, Trash2 } from "lucide-react";
import { BioLink, Link } from "@/types";
import { toast } from "sonner";

type LinksPageProps = {
  links: Link[];
  bio_links: BioLink[];
};

export default function Links({ links, bio_links }: LinksPageProps) {
  const {
    data,
    setData,
    reset,
    post,
    delete: deleteLink,
    processing,
    errors,
  } = useForm({
    original_url: "",
  });

  const handleCreateLink = (e: React.FormEvent) => {
    e.preventDefault();

    post("/links", {
      onSuccess: () => {
        reset();
        toast.success("Link criar com sucesso!");
      },
    });
  };

  const handleDeleteLink = (id: string) => {
    deleteLink(`/links/${id}`, {
      onSuccess: () => {
        reset();
        toast.success("Link deletado com sucesso!");
      },
    });
  };

  const renderBioLink = (bioLink: BioLink) => {
    return (
      <div className="flex flex-col gap-2">
        {bioLink && (
          <Card>
            <CardHeader>
              <CardTitle>Seu link para Bio</CardTitle>
            </CardHeader>
            <CardContent>
              <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>Link Encurtado</TableHead>
                    <TableHead>Visitas</TableHead>
                    <TableHead>Criado em</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  <TableRow>
                    <TableCell>
                      <a
                        href={bioLink.link.short_url}
                        target="_blank"
                        rel="noreferrer"
                        className="underline"
                      >
                        {bioLink.link.short_url}
                      </a>
                    </TableCell>
                    <TableCell>{bioLink.link.visit_count ?? 0}</TableCell>
                    <TableCell>
                      {new Date(bioLink.link.inserted_at).toLocaleDateString("pt-BR")}
                    </TableCell>
                  </TableRow>
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        )}
        <BioLinkGenerator bioLink={bioLink} />
      </div>
    );
  };

  return (
    <Layout>
      <div className="flex flex-col gap-4">
        <h1 className="text-2xl font-bold mb-6">Encurtador de Links</h1>
        <Card className="mb-6">
          <CardHeader>
            <CardTitle>Criar Novo Link</CardTitle>
            <CardDescription>Insira a URL que você deseja encurtar</CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleCreateLink} className="flex space-x-2">
              <div className="w-full">
                <Input
                  type="url"
                  placeholder="https://www.exemplo.com"
                  value={data.original_url}
                  onChange={(e) => setData("original_url", e.target.value)}
                  required
                />
                {errors.original_url && (
                  <p className="text-sm text-red-500">
                    Url de origem {errors.original_url}
                  </p>
                )}
              </div>
              <Button type="submit">
                {processing ? <Loader2 className="animate-spin" /> : "Criar"}
              </Button>
            </form>
          </CardContent>
        </Card>
        <Card>
          <CardHeader>
            <CardTitle>Seus Links Encurtados</CardTitle>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Link Encurtado</TableHead>
                  <TableHead>URL Original</TableHead>
                  <TableHead>Visitas</TableHead>
                  <TableHead>Criado em</TableHead>
                  <TableHead></TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {links?.map((link) => (
                  <TableRow key={link.id}>
                    <TableCell className="font-medium">
                      <a
                        href={link.short_url}
                        target="_blank"
                        rel="noreferrer"
                        className="underline"
                      >
                        {link.short_url}
                      </a>
                    </TableCell>
                    <TableCell>
                      <a
                        href={link.original_url}
                        target="_blank"
                        rel="noreferrer"
                        className="underline"
                      >
                        {link.original_url}
                      </a>
                    </TableCell>
                    <TableCell>{link.visit_count ?? 0}</TableCell>
                    <TableCell>
                      {new Date(link.inserted_at).toLocaleDateString("pt-BR")}
                    </TableCell>
                    <TableCell>
                      <Button
                        variant="destructive"
                        onClick={() => handleDeleteLink(link.id)}
                      >
                        <Trash2 size={16} />
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </CardContent>
        </Card>
        <div className="flex flex-col gap-4">
          <h2 className="text-2xl font-bold">Gere um link para sua Bio</h2>
          <Deferred data="bio_links" fallback={<div>Loading...</div>}>
            {renderBioLink(bio_links?.[0])}
          </Deferred>
        </div>
      </div>
    </Layout>
  );
}
