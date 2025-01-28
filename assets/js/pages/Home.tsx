import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";

export default function Home() {
  return (
    <div className="flex flex-col min-h-screen">
      <main className="flex-grow">
        <section className="bg-gradient-to-b from-primary to-primary/50 text-primary-foreground py-20">
          <div className="container mx-auto px-4 text-center">
            <h2 className="text-4xl font-bold mb-4">
              Encurte seus links, expanda suas possibilidades
            </h2>
            <p className="text-xl mb-8">
              Crie links curtos e personalizados em segundos. Perfeito para redes sociais,
              marketing e muito mais!
            </p>
            <Button size="lg" asChild>
              <a href="/users/register">Comece Gratuitamente</a>
            </Button>
          </div>
        </section>

        <section id="features" className="py-20">
          <div className="container mx-auto px-4">
            <h2 className="text-3xl font-bold text-center mb-12">Recursos Incríveis</h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
              <Card>
                <CardHeader>
                  <CardTitle>Links Rápidos</CardTitle>
                </CardHeader>
                <CardContent>
                  <p>
                    Crie links curtos em segundos e compartilhe-os facilmente em qualquer
                    plataforma.
                  </p>
                </CardContent>
              </Card>
              <Card>
                <CardHeader>
                  <CardTitle>Estatísticas Detalhadas</CardTitle>
                </CardHeader>
                <CardContent>
                  <p>
                    Acompanhe o desempenho dos seus links com estatísticas em tempo real
                    de cliques e localizações.
                  </p>
                </CardContent>
              </Card>
              <Card>
                <CardHeader>
                  <CardTitle>Personalização</CardTitle>
                </CardHeader>
                <CardContent>
                  <p>
                    Crie links personalizados que reflitam sua marca e sejam fáceis de
                    lembrar.
                  </p>
                </CardContent>
              </Card>
            </div>
          </div>
        </section>

        <section id="pricing" className="bg-muted py-20">
          <div className="container mx-auto px-4">
            <h2 className="text-3xl font-bold text-center mb-12">
              Planos Simples e Acessíveis
            </h2>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-3xl mx-auto">
              <Card>
                <CardHeader>
                  <CardTitle>Plano Gratuito</CardTitle>
                  <CardDescription>Perfeito para começar</CardDescription>
                </CardHeader>
                <CardContent>
                  <ul className="list-disc list-inside mb-6">
                    <li>Até 3 links encurtados</li>
                    <li>Estatísticas básicas</li>
                    <li>Links válidos por 30 dias</li>
                  </ul>
                  <Button className="w-full" variant="outline">
                    Começar Grátis
                  </Button>
                </CardContent>
              </Card>
              <Card>
                <CardHeader>
                  <CardTitle>Plano Pro</CardTitle>
                  <CardDescription>Para usuários avançados</CardDescription>
                </CardHeader>
                <CardContent>
                  <ul className="list-disc list-inside mb-6">
                    <li>Links ilimitados</li>
                    <li>Estatísticas avançadas</li>
                    <li>Links permanentes</li>
                    <li>Personalização de links</li>
                    <li>Suporte prioritário</li>
                  </ul>
                  <Button className="w-full">Assinar por R$10/mês</Button>
                </CardContent>
              </Card>
            </div>
          </div>
        </section>

        <section className="py-20">
          <div className="container mx-auto px-4 text-center">
            <h2 className="text-3xl font-bold mb-8">Pronto para começar?</h2>
            <Button size="lg" asChild>
              <a href="/users/register">Crie sua conta gratuitamente</a>
            </Button>
          </div>
        </section>
      </main>

      <footer className="bg-muted py-8">
        <div className="container mx-auto px-4 text-center">
          <p>&copy; 2023 Magic Link. Todos os direitos reservados.</p>
          <nav className="mt-4">
            <ul className="flex justify-center space-x-4">
              <li>
                <a href="/terms" className="hover:underline">
                  Termos de Uso
                </a>
              </li>
              <li>
                <a href="/privacy" className="hover:underline">
                  Política de Privacidade
                </a>
              </li>
              <li>
                <a href="/contact" className="hover:underline">
                  Contato
                </a>
              </li>
            </ul>
          </nav>
        </div>
      </footer>
    </div>
  );
}
