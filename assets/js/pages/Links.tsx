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
import { useForm } from "@inertiajs/react";
import { Loader2 } from "lucide-react";

interface Link {
  id: string;
  originalUrl: string;
  shortUrl: string;
  visitCount: number;
  insertedAt: string;
}

type LinksPageProps = {
  links: Link[];
};

export default function Links({ links }: LinksPageProps) {
  console.log(links);

  const { data, setData, reset, post, processing, errors } = useForm({
    original_url: "",
  });

  const handleCreateLink = (e: React.FormEvent) => {
    e.preventDefault();

    post("/links", {
      onSuccess: () => {
        reset();
      },
    });
  };

  return (
    <Layout>
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
              </TableRow>
            </TableHeader>
            <TableBody>
              {links?.map((link) => (
                <TableRow key={link.id}>
                  <TableCell className="font-medium">
                    <a
                      href={link.shortUrl}
                      target="_blank"
                      rel="noreferrer"
                      className="underline"
                    >
                      {link.shortUrl}
                    </a>
                  </TableCell>
                  <TableCell>
                    <a
                      href={link.originalUrl}
                      target="_blank"
                      rel="noreferrer"
                      className="underline"
                    >
                      {link.originalUrl}
                    </a>
                  </TableCell>
                  <TableCell>{link.visitCount ?? 0}</TableCell>
                  <TableCell>
                    {new Date(link.insertedAt).toLocaleDateString("pt-BR")}
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
      <div className="mt-8">
        <h2 className="text-2xl font-bold mb-4">Gere um link para sua Bio</h2>
        <BioLinkGenerator />
      </div>
    </Layout>
  );
}
