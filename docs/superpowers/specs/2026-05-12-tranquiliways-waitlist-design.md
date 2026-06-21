# TranquiliWays — Waitlist Page Design Spec
**Data:** 2026-05-12
**Status:** Aprovado pelo usuário

---

## Visão Geral

Página de waitlist do TranquiliWays. Única tela responsiva (mobile-first) em HTML/CSS/JS puro. Sem frameworks externos além de Google Fonts e ícones SVG inline.

**Objetivo primário:** Coletar dilemas reais dos usuários antes do lançamento — e opcionalmente capturar o email após o envio.

---

## Copy

| Elemento | Texto |
|---|---|
| Badge | `Em breve` |
| Headline | `Traga o futuro para o presente.` |
| Subheadline | `Viva o prazer — ou a dor — de cada escolha antes de fazê-la.` |
| Fechamento | `Conheça e viva suas Ways.` |
| Placeholder textarea | `Qual é o seu dilema hoje?` |
| Botão enviar | `Viver minhas Ways →` |
| Card 1 | Encruzilhada / dois caminhos |
| Card 2 | Adiamento / aquela decisão |
| Card 3 | Coração Dividido / quando você briga com você |
| Título sucesso | `Recebemos seu dilema.` |
| Sub sucesso | `Em breve, suas Ways vão ganhar forma.` |
| Prompt email | `Quer saber quando estiver pronto?` |
| Placeholder email | `seu@email.com` |
| Botão email | `Avisar →` |
| Skip email | `Não, obrigado` |

---

## Fluxo de Estados

### Estado 1 — Entrada do dilema
- Badge "Em breve"
- Headline + Subheadline
- 3 mini cards (Encruzilhada, Adiamento, Coração Dividido)
- Textarea 3D branca grande (dilema)
- Botão amarelo "Viver minhas Ways →"
- Linha de fechamento "Conheça e viva suas Ways."

### Estado 2 — Pós-envio (obrigado + email opcional)
- Ícone SVG de confirmação (checkmark, não emoji)
- "Recebemos seu dilema."
- "Em breve, suas Ways vão ganhar forma."
- Separador sutil
- Prompt: "Quer saber quando estiver pronto?"
- Input email + botão "Avisar →" (na mesma linha)
- Link discreto: "Não, obrigado"

---

## Identidade Visual

### Paleta
| Token | Valor | Uso |
|---|---|---|
| `--sky` | `#5cc3ff` | Fundo principal (dominante) |
| `--sun` | `#ffdb58` | Botão CTA, focus ring, destaques |
| `--white` | `#ffffff` | Texto principal, cards, inputs |
| `--white-75` | `rgba(255,255,255,0.75)` | Texto secundário |
| `--white-60` | `rgba(255,255,255,0.60)` | Texto terciário, linha fechamento |
| `--white-18` | `rgba(255,255,255,0.18)` | Fundo dos mini cards |
| `--sky-deep` | `#3ab0f0` | Sombra 3D camada 1 |
| `--sky-deeper` | `#1a9de0` | Sombra 3D camada 2 |
| `--dark` | `#1a1a2e` | Texto no botão amarelo |
| `--badge-bg` | `rgba(255,255,255,0.20)` | Fundo do badge |

### Tipografia
| Elemento | Fonte | Peso | Tamanho |
|---|---|---|---|
| Headline | Peace Sans | 700 | `clamp(28px, 8vw, 44px)` |
| Badge, labels | Peace Sans | 400 | `11px` |
| Corpo, sub, cards | Open Sauce One | 300–400 | `14–16px` |
| Placeholder textarea | Open Sauce One | 300 | `14px` |
| Botão | Open Sauce One | 600 | `14px` |

> **Nota de carregamento:** Peace Sans não está no Google Fonts. Estratégia: incorporar a fonte como `@font-face` com arquivo `.woff2` baixado do DaFont e colocado em `fonts/PeaceSans.woff2` dentro do projeto. Open Sauce One via Google Fonts (`@import`). Fallback: `'Nunito', sans-serif` para Peace Sans; `'Inter', sans-serif` para Open Sauce.

### Luzes ambiente (substituem orbs escuros)
- 2–3 `radial-gradient` brancos, `opacity: 0.12–0.18`, `position: fixed`, `pointer-events: none`
- Movimento lento: `animation-duration: 16–22s`, `ease-in-out`, `alternate`
- Simulam luz solar difusa — não manchas brilhantes

---

## Componentes

### Badge "Em breve"
```
fundo: rgba(255,255,255,0.20)
borda: 0.5px solid rgba(255,255,255,0.35)
border-radius: 100px
padding: 5px 14px
fonte: Peace Sans, 10px, uppercase, letter-spacing: 0.12em
cor texto: #ffffff
dot-pulse: branco, animação pulse 1.8s
```

### Mini Cards (Encruzilhada, Adiamento, Coração Dividido) — decorativos, não clicáveis
```
fundo: rgba(255,255,255,0.18)
borda: 0.5px solid rgba(255,255,255,0.30)
border-radius: 12px
padding: 12px 10px
ícone: SVG inline (branch, pause, scale) — cor branca
nome: Open Sauce One 600, 11px, branco
label: Open Sauce One 300, 9px, branco 70%, uppercase
hover: translateY(-2px), 200ms ease-out
stagger entrada: 50ms entre cards
```

### Textarea 3D (elemento principal)
```
background: #ffffff
border: none
border-radius: 16px
padding: 20px 18px
min-height: 100px
resize: none
font: Open Sauce One, 14px, #1a1a2e
placeholder: rgba(26,26,46,0.35)

box-shadow (efeito 3D):
  0 4px 0 0 #3ab0f0,
  0 8px 0 0 #1a9de0,
  0 1px 16px rgba(0,100,200,0.08)

:hover → translateY(-2px) + sombra cresce levemente, 150ms ease-out
:focus → outline: none
         box-shadow adiciona: 0 0 0 3px rgba(255,219,88,0.45)
         translateY(-2px)
```

### Botão principal (amarelo)
```
background: #ffdb58
color: #1a1a2e
border: none
border-radius: 10px
padding: 13px 20px
font: Open Sauce One 600, 14px
letter-spacing: 0.01em
width: 100%
transition: background 200ms ease-out, transform 100ms ease-out
:hover → background: #ffe880
:active → transform: scale(0.97)
:disabled → background: rgba(255,219,88,0.45), cursor: not-allowed
```

### Input email (Estado 2)
```
layout: flex row (input + botão)
input: fundo branco, borda rgba(255,255,255,0.5), border-radius: 10px
botão: amarelo, mesmo estilo do botão principal
:focus input → borda branca sólida 1.5px
```

### Link "Não, obrigado"
```
display: block
text-align: center
margin-top: 10px
font: Open Sauce One 300, 12px
color: rgba(255,255,255,0.55)
cursor: pointer
:hover → color: rgba(255,255,255,0.85)
sem sublinhado

Comportamento ao clicar: oculta o bloco de email (fade out 200ms),
exibe linha final "Até breve. Suas Ways te esperam." — sem redirecionar.
```

---

## Animações

| Elemento | Tipo | Propriedades | Duração | Easing |
|---|---|---|---|---|
| Todos os blocos entrada | fadeUp escalonado | `opacity 0→1`, `translateY(12px→0)` | `300ms` | `cubic-bezier(0.23,1,0.32,1)` |
| Mini cards | stagger entre itens | mesmas props | `300ms` + `50ms delay` por card | mesma |
| Textarea hover | lift | `translateY(-2px)` | `150ms` | `ease-out` |
| Textarea focus | lift + ring amarelo | `box-shadow` | `150ms` | `ease-out` |
| Botão `:active` | press | `scale(0.97)` | `100ms` | `ease-out` |
| Transição Estado 1→2 | fade + lift | `opacity 0→1`, `translateY(12px→0)` | `400ms` | `cubic-bezier(0.23,1,0.32,1)` |
| Luzes ambiente | drift | `translate` | `16–22s` | `ease-in-out alternate` |
| Badge dot | pulse | `opacity`, `scale` | `1.8s` | `ease-in-out infinite` |

**Regras:**
- Nunca animar `width`, `height`, `padding` — apenas `transform` e `opacity`
- Nenhuma animação de entrada de `scale(0)` — mínimo `scale(0.96)`
- `prefers-reduced-motion`: desabilitar transforms, manter opacity fades

---

## Responsividade

- **Mobile-first** — base: `375px`
- Padding lateral: `1.5rem`
- Mini cards: `flex-row`, `flex: 1` — se não couber em 375px, empilhar 2+1
- Textarea: `width: 100%`
- Max-width container: `440px`, centralizado em telas maiores
- Headline: `clamp(28px, 8vw, 44px)` — se adapta fluidamente

---

## Acessibilidade

- `aria-label` em botões com ícone/seta
- `role="alert"` no Estado 2 para screen readers
- `autocomplete="email"` no input de email
- `type="email"` para teclado correto no mobile
- Contraste: branco sobre `#5cc3ff` = 3.2:1 (grande texto ✓, pequeno texto — aceito para elemento decorativo; textos críticos em branco puro sobre fundo escuro via badge/cards)
- Focus visible em todos os interativos
- `prefers-reduced-motion` respeitado

---

## Fora do Escopo

- Backend / armazenamento real de emails (mock com `setTimeout`)
- Instagram CTA (removido)
- Barra de progresso (removida)
- Múltiplas páginas
- Dark mode
