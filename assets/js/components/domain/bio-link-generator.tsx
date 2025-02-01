import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import { BioLink } from "@/types";
import { Trash2 } from "lucide-react";
import { useForm } from "@inertiajs/react";

type BioLinkGeneratorProps = {
  bioLink?: BioLink;
};

export function BioLinkGenerator({ bioLink }: BioLinkGeneratorProps) {
  const {
    data,
    setData,
    post,
    delete: deleteBioLink,
    processing,
    errors,
  } = useForm({
    title: bioLink?.title ?? "",
    description: bioLink?.description ?? "",
    banner: bioLink?.banner ?? "",
    external_links: bioLink?.external_links ?? [],
  });

  const addExternal = () => {
    setData((prev) => ({
      ...prev,
      external_links: [
        ...prev.external_links,
        {
          id: "",
          title: "",
          url: "",
          bio_link_id: "",
        },
      ],
    }));
  };

  const updateExternalLink = (id: string, field: "title" | "url", value: string) => {
    setData((prev) => ({
      ...prev,
      external_links: prev.external_links.map((link) =>
        link.id === id ? { ...link, [field]: value } : link,
      ),
    }));
  };

  const removeExternalLink = (id: string) => {
    setData((prev) => ({
      ...prev,
      external_links: prev.external_links.filter((link) => link.id !== id),
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
                value={data.title}
                onChange={(e) => setData((prev) => ({ ...prev, title: e.target.value }))}
                placeholder="Seu nome ou título da página"
              />
              {errors.title && <p className="text-sm text-red-500">Título inválido</p>}
            </div>
            <div>
              <Label htmlFor="description">Descrição</Label>
              <Textarea
                id="description"
                value={data.description}
                onChange={(e) =>
                  setData((prev) => ({ ...prev, description: e.target.value }))
                }
                placeholder="Uma breve descrição sobre você ou sua página"
              />
              {errors.description && (
                <p className="text-sm text-red-500">Descrição inválida</p>
              )}
            </div>
            <div>
              <Label htmlFor="banner">URL do Banner</Label>
              <Input
                id="banner"
                value={data.banner}
                onChange={(e) => setData((prev) => ({ ...prev, banner: e.target.value }))}
                placeholder="https://exemplo.com/seu-banner.jpg"
              />
              {errors.banner && <p className="text-sm text-red-500">Banner inválido</p>}
            </div>
            <div>
              <Label>Links Pessoais</Label>
              {data.external_links.map((link) => (
                <div key={link.id} className="flex space-x-2 mt-2">
                  <Input
                    value={link.title}
                    onChange={(e) => updateExternalLink(link.id, "title", e.target.value)}
                    placeholder="Título do link"
                  />
                  <Input
                    value={link.url}
                    onChange={(e) => updateExternalLink(link.id, "url", e.target.value)}
                    placeholder="URL"
                  />
                  <Button
                    type="button"
                    variant="destructive"
                    onClick={() => removeExternalLink(link.id)}
                  >
                    <Trash2 size={16} />
                  </Button>
                </div>
              ))}
              {errors.external_links && (
                <p className="text-sm text-red-500">Link mal configurado</p>
              )}
              <Button type="button" onClick={addExternal} className="mt-2">
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
            {data.banner && (
              <img
                src={data.banner || "/placeholder.svg"}
                alt="Banner"
                className="w-full h-32 object-cover rounded-lg"
              />
            )}
            <h2 className="text-2xl font-bold">{data.title || "Seu Título"}</h2>
            <p className="text-gray-600">
              {data.description ?? "Sua descrição aparecerá aqui"}
            </p>
            <div className="space-y-2">
              {data.external_links.map((link) => (
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
          <div className="mt-4">
            <Button
              onClick={() => post("/links/bio", { preserveScroll: true })}
              disabled={processing}
              className="w-full"
            >
              {processing ? "Salvando..." : "Salvar Link da Bio"}
            </Button>
            <Button
              variant={"destructive"}
              onClick={() => deleteBioLink("/links/bio", { preserveScroll: true })}
              disabled={processing}
              className="w-full"
            >
              {processing ? "Deletando..." : "Deletar Link da Bio"}
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
