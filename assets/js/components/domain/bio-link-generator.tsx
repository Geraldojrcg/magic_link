import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import { BioLink, BioLinkForm } from "@/types";
import { Trash2 } from "lucide-react";
import { useForm } from "@inertiajs/react";
import { toast } from "sonner";
import { BioLinkPreview } from "./bio-link-preview";

type BioLinkGeneratorProps = {
  bioLink?: BioLink;
};

export function BioLinkGenerator({ bioLink }: BioLinkGeneratorProps) {
  const {
    data,
    setData,
    post,
    patch,
    delete: deleteBioLink,
    processing,
    errors,
    isDirty,
    transform,
  } = useForm<BioLinkForm>({
    title: bioLink?.title ?? "",
    description: bioLink?.description ?? "",
    banner: bioLink?.banner ?? "",
    external_links: bioLink?.external_links ?? [],
  });

  transform((data) => ({
    ...data,
    external_links: data.external_links.map((link) => ({
      title: link.title,
      url: link.url,
    })),
  }));

  const addExternalLink = () => {
    setData((prev) => ({
      ...prev,
      external_links: [
        ...prev.external_links,
        {
          id: Date.now().toString(),
          title: "",
          url: "",
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

  const handleCreateBioLink = (e: React.FormEvent) => {
    e.preventDefault();

    if (isDirty && bioLink?.id) {
      patch(`/links/bio/${bioLink.id}`, {
        preserveScroll: true,
        onSuccess: () => {
          toast.success("Link da Bio atualizado com sucesso!");
        },
      });

      return;
    }

    post("/links/bio", {
      preserveScroll: true,
      onSuccess: () => {
        toast.success("Link da Bio criado com sucesso!");
      },
    });
  };

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
      <Card>
        <CardHeader>
          <CardTitle>Configure um link para seu Bio</CardTitle>
        </CardHeader>
        <CardContent>
          <form className="flex flex-col gap-4" onSubmit={handleCreateBioLink}>
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
                type="url"
                value={data.banner}
                onChange={(e) => setData((prev) => ({ ...prev, banner: e.target.value }))}
                placeholder="https://exemplo.com/seu-banner.jpg"
                required
              />
              {errors.banner && <p className="text-sm text-red-500">Banner inválido</p>}
            </div>
            <div className="flex justify-between items-center">
              <Label className="font-bold">Links Pessoais</Label>
              <Button type="button" onClick={addExternalLink} className="mt-2">
                Adicionar Link
              </Button>
            </div>
            <div>
              {data.external_links.map((link) => (
                <div key={link.id} className="flex space-x-2 mt-2">
                  <Input
                    value={link.title}
                    onChange={(e) => updateExternalLink(link.id, "title", e.target.value)}
                    placeholder="Título do link"
                  />
                  <Input
                    type="url"
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
            </div>
            <hr className="my-2" />
            <div className="flex flex-col gap-2 mt-4">
              <Button type="submit" disabled={processing} className="w-full">
                {processing ? "Salvando..." : "Salvar"}
              </Button>
              <Button
                variant={"destructive"}
                onClick={() => deleteBioLink("/links/bio", { preserveScroll: true })}
                disabled={processing}
                className="w-full"
              >
                {processing ? "Deletando..." : "Deletar"}
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
          <BioLinkPreview bioLink={data} />
        </CardContent>
      </Card>
    </div>
  );
}
