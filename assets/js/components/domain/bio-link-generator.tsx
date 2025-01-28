import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Label } from "@/components/ui/label";

interface PersonalLink {
  id: string;
  title: string;
  url: string;
}

interface BioLinkGenerator {
  title: string;
  description: string;
  banner: string;
  personalLinks: PersonalLink[];
}

export function BioLinkGenerator() {
  const [config, setConfig] = useState<BioLinkGenerator>({
    title: "",
    description: "",
    banner: "",
    personalLinks: [],
  });

  const addPersonalLink = () => {
    setConfig((prev) => ({
      ...prev,
      personalLinks: [
        ...prev.personalLinks,
        { id: Date.now().toString(), title: "", url: "" },
      ],
    }));
  };

  const updatePersonalLink = (id: string, field: "title" | "url", value: string) => {
    setConfig((prev) => ({
      ...prev,
      personalLinks: prev.personalLinks.map((link) =>
        link.id === id ? { ...link, [field]: value } : link,
      ),
    }));
  };

  const removePersonalLink = (id: string) => {
    setConfig((prev) => ({
      ...prev,
      personalLinks: prev.personalLinks.filter((link) => link.id !== id),
    }));
  };

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
      <Card>
        <CardHeader>
          <CardTitle>Configurar Link do Instagram</CardTitle>
        </CardHeader>
        <CardContent>
          <form className="space-y-4">
            <div>
              <Label htmlFor="title">Título</Label>
              <Input
                id="title"
                value={config.title}
                onChange={(e) =>
                  setConfig((prev) => ({ ...prev, title: e.target.value }))
                }
                placeholder="Seu nome ou título da página"
              />
            </div>
            <div>
              <Label htmlFor="description">Descrição</Label>
              <Textarea
                id="description"
                value={config.description}
                onChange={(e) =>
                  setConfig((prev) => ({ ...prev, description: e.target.value }))
                }
                placeholder="Uma breve descrição sobre você ou sua página"
              />
            </div>
            <div>
              <Label htmlFor="banner">URL do Banner</Label>
              <Input
                id="banner"
                value={config.banner}
                onChange={(e) =>
                  setConfig((prev) => ({ ...prev, banner: e.target.value }))
                }
                placeholder="https://exemplo.com/seu-banner.jpg"
              />
            </div>
            <div>
              <Label>Links Pessoais</Label>
              {config.personalLinks.map((link) => (
                <div key={link.id} className="flex space-x-2 mt-2">
                  <Input
                    value={link.title}
                    onChange={(e) => updatePersonalLink(link.id, "title", e.target.value)}
                    placeholder="Título do link"
                  />
                  <Input
                    value={link.url}
                    onChange={(e) => updatePersonalLink(link.id, "url", e.target.value)}
                    placeholder="URL"
                  />
                  <Button
                    type="button"
                    variant="destructive"
                    onClick={() => removePersonalLink(link.id)}
                  >
                    Remover
                  </Button>
                </div>
              ))}
              <Button type="button" onClick={addPersonalLink} className="mt-2">
                Adicionar Link
              </Button>
            </div>
          </form>
        </CardContent>
      </Card>
      <Card>
        <CardHeader>
          <CardTitle>Visualização</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="border rounded-lg p-4 space-y-4">
            {config.banner && (
              <img
                src={config.banner || "/placeholder.svg"}
                alt="Banner"
                className="w-full h-32 object-cover rounded-lg"
              />
            )}
            <h2 className="text-2xl font-bold">{config.title || "Seu Título"}</h2>
            <p className="text-gray-600">
              {config.description || "Sua descrição aparecerá aqui"}
            </p>
            <div className="space-y-2">
              {config.personalLinks.map((link) => (
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
        </CardContent>
      </Card>
    </div>
  );
}
