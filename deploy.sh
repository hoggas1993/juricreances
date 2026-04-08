#!/bin/bash
# ══════════════════════════════════════════════════════════════════
#  JuriCréances — Script de déploiement Vercel
#  Exécuter depuis le dossier juricreances/ sur votre machine
#  Prérequis : Node.js ≥ 18, npm, Git installés
# ══════════════════════════════════════════════════════════════════

set -e  # Arrêter en cas d'erreur

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   JuriCréances — Déploiement Vercel      ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# ── 1. Vérifications préalables ──────────────────────────────────
echo "► Vérification des outils..."
node --version || { echo "❌ Node.js requis (https://nodejs.org)"; exit 1; }
npm --version  || { echo "❌ npm requis"; exit 1; }
git --version  || { echo "❌ Git requis (https://git-scm.com)"; exit 1; }

# ── 2. Installation Vercel CLI ────────────────────────────────────
echo ""
echo "► Installation de la Vercel CLI..."
npm install -g vercel

# ── 3. Installation des dépendances ──────────────────────────────
echo ""
echo "► Installation des dépendances npm..."
npm install

# ── 4. Build de vérification ──────────────────────────────────────
echo ""
echo "► Build de vérification..."
npm run build
echo "✅ Build réussi"

# ── 5. Initialisation Git (si nécessaire) ─────────────────────────
echo ""
if [ ! -d ".git" ]; then
  echo "► Initialisation du dépôt Git..."
  git init
  git add .
  git commit -m "JuriCréances v1.0 — déploiement initial"
else
  echo "► Mise à jour du dépôt Git..."
  git add .
  git commit -m "JuriCréances — mise à jour $(date '+%Y-%m-%d %H:%M')" || echo "(aucun changement à commiter)"
fi

# ── 6. Déploiement Vercel ─────────────────────────────────────────
echo ""
echo "► Déploiement vers Vercel..."
echo "   (Connexion à votre compte Vercel requise)"
echo ""
vercel --prod

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║  ✅ Déploiement terminé !                                    ║"
echo "║                                                              ║"
echo "║  ÉTAPES SUIVANTES — À faire dans le Dashboard Vercel :      ║"
echo "║                                                              ║"
echo "║  1. Settings → Environment Variables                        ║"
echo "║     → Copier toutes les variables de .env.example           ║"
echo "║                                                              ║"
echo "║  2. Stripe → Developers → Webhooks                          ║"
echo "║     → Endpoint : https://votre-domaine/api/webhook          ║"
echo "║     → Événement : checkout.session.completed                ║"
echo "║     → Copier le Signing Secret dans STRIPE_WEBHOOK_SECRET   ║"
echo "║                                                              ║"
echo "║  3. Vercel → Storage → Blob → Create Store                  ║"
echo "║     → Copier le token dans BLOB_READ_WRITE_TOKEN             ║"
echo "║                                                              ║"
echo "║  4. YouSign → Paramètres → API                              ║"
echo "║     → Copier la clé dans YOUSIGN_API_KEY                    ║"
echo "║     → Mettre YOUSIGN_SANDBOX=true pour les tests            ║"
echo "║                                                              ║"
echo "║  5. Redéployer après les variables :                        ║"
echo "║     vercel --prod                                            ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
