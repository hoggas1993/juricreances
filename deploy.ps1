# ══════════════════════════════════════════════════════════════
#  JuriCréances — Script de déploiement Vercel (PowerShell)
#  Double-cliquez sur ce fichier ou collez les commandes une par une
# ══════════════════════════════════════════════════════════════

Write-Host ""
Write-Host "╔══════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   JuriCréances — Déploiement Vercel      ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# 1. Installer Vercel CLI
Write-Host "► Installation de Vercel CLI..." -ForegroundColor Yellow
npm install -g vercel

# 2. Installer les dépendances du projet
Write-Host ""
Write-Host "► Installation des dépendances..." -ForegroundColor Yellow
npm install

# 3. Vérification du build
Write-Host ""
Write-Host "► Vérification du build..." -ForegroundColor Yellow
npm run build

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Le build a échoué. Contactez votre développeur." -ForegroundColor Red
    exit 1
}

Write-Host "✅ Build réussi !" -ForegroundColor Green

# 4. Déploiement
Write-Host ""
Write-Host "► Déploiement vers Vercel..." -ForegroundColor Yellow
Write-Host "   → Connectez-vous à votre compte Vercel quand demandé" -ForegroundColor Gray
Write-Host ""
vercel --prod

Write-Host ""
Write-Host "✅ Déploiement terminé !" -ForegroundColor Green
Write-Host ""
Write-Host "N'oubliez pas d'ajouter vos variables dans Vercel → Settings → Environment Variables" -ForegroundColor Yellow
Write-Host "(voir le fichier .env.example pour la liste complète)" -ForegroundColor Gray
