/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  // Redirige /questionnaire vers /questionnaire.html (fichier HTML statique dans /public)
  async redirects() {
    return [
      {
        source: '/questionnaire',
        destination: '/questionnaire.html',
        permanent: false,
      },
    ]
  },
  // Le webhook Stripe nécessite le raw body — désactiver le body parser pour cette route
  experimental: {
    serverComponentsExternalPackages: ['stripe'],
  },
}

module.exports = nextConfig
