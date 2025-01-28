"use client";

import { useState } from "react";
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

interface Link {
  id: string;
  originalUrl: string;
  shortUrl: string;
  visits: number;
  lastVisited: Date | null;
}

export default function Links() {
  const [links, setLinks] = useState<Link[]>([
    {
      id: "1",
      originalUrl: "https://www.exemplo.com",
      shortUrl: "https://encurta.do/abc123",
      visits: 5,
      lastVisited: new Date("2023-05-15T10:30:00"),
    },
    {
      id: "2",
      originalUrl: "https://www.outroexemplo.com",
      shortUrl: "https://encurta.do/def456",
      visits: 10,
      lastVisited: new Date("2023-05-16T14:45:00"),
    },
  ]);
  const [newUrl, setNewUrl] = useState("");

  const handleCreateLink = (e: React.FormEvent) => {
    e.preventDefault();
    if (newUrl) {
      const newLink: Link = {
        id: Date.now().toString(),
        originalUrl: newUrl,
        shortUrl: `https://encurta.do/${Math.random().toString(36).substr(2, 6)}`,
        visits: 0,
        lastVisited: null,
      };
      setLinks([...links, newLink]);
      setNewUrl("");
    }
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
            <Input
              type="url"
              placeholder="https://www.exemplo.com"
              value={newUrl}
              onChange={(e) => setNewUrl(e.target.value)}
              required
            />
            <Button type="submit">Criar Link</Button>
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
                <TableHead>URL Original</TableHead>
                <TableHead>Link Encurtado</TableHead>
                <TableHead>Visitas</TableHead>
                <TableHead>Último Acesso</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {links.map((link) => (
                <TableRow key={link.id}>
                  <TableCell className="font-medium">{link.originalUrl}</TableCell>
                  <TableCell>{link.shortUrl}</TableCell>
                  <TableCell>{link.visits}</TableCell>
                  <TableCell>
                    {link.lastVisited
                      ? link.lastVisited.toLocaleString()
                      : "Nunca acessado"}
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
