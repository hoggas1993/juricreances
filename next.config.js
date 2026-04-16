/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,

  // ── Redirections ────────────────────────────────────────────────
  async redirects() {
    return [
      {
        source: '/questionnaire',
        destination: '/questionnaire.html',
        permanent: false,
      },
    ]
  },

  // ── Headers de sécurité HTTP ────────────────────────────────────
  // Critiques pour un site juridique traitant des données sensibles
  async headers() {
    return [
      {
        // Appliquer à toutes les routes
        source: '/(.*)',
        headers: [
          // ── Protection contre le clickjacking ──
          {
            key: 'X-Frame-Options',
            value: 'DENY',
          },
          // ── Empêcher le MIME sniffing ──
          {
            key: 'X-Content-Type-Options',
            value: 'nosniff',
          },
          // ── Forcer HTTPS (1 an + sous-domaines) ──
          {
            key: 'Strict-Transport-Security',
            value: 'max-age=31536000; includeSubDomains; preload',
          },
          // ── Protection XSS navigateurs anciens ──
          {
            key: 'X-XSS-Protection',
            value: '1; mode=block',
          },
          // ── Contrôler le Referrer envoyé aux tiers ──
          {
            key: 'Referrer-Policy',
            value: 'strict-origin-when-cross-origin',
          },
          // ── Désactiver les API navigateur non nécessaires ──
          {
            key: 'Permissions-Policy',
            value: 'camera=(), microphone=(), geolocation=(), payment=(self)',
          },
          // ── Content Security Policy ──
          // Protège contre XSS, injection de scripts, data exfiltration
          {
            key: 'Content-Security-Policy',
            value: [
              "default-src 'self'",
              "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://js.stripe.com https://www.googletagmanager.com https://www.google-analytics.com",
              "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com",
              "font-src 'self' https://fonts.gstatic.com data:",
              "img-src 'self' data: blob: https://*.stripe.com https://www.google-analytics.com https://www.googletagmanager.com",
              "frame-src 'self' https://js.stripe.com https://hooks.stripe.com",
              "connect-src 'self' https://api.stripe.com https://*.supabase.co https://*.supabase.in wss://*.supabase.co https://api.brevo.com https://www.google-analytics.com",
              "object-src 'none'",
              "base-uri 'self'",
              "form-action 'self'",
              "frame-ancestors 'none'",
              "upgrade-insecure-requests",
            ].join('; '),
          },
          // ── DNS Prefetch ──
          {
            key: 'X-DNS-Prefetch-Control',
            value: 'on',
          },
        ],
      },
      {
        // Routes API — interdire le cache (données sensibles)
        source: '/api/(.*)',
        headers: [
          {
            key: 'Cache-Control',
            value: 'no-store, no-cache, must-revalidate, proxy-revalidate',
          },
          {
            key: 'Pragma',
            value: 'no-cache',
          },
        ],
      },
    ]
  },

  // ── Stripe : raw body nécessaire pour le webhook ────────────────
  experimental: {
    serverComponentsExternalPackages: ['stripe'],
  },
}

module.exports = nextConfig
