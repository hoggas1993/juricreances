/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './src/**/*.{js,jsx,ts,tsx}',
  ],
  theme: {
    extend: {
      colors: {
        navy: {
          50: '#f0f3f9',
          100: '#d9e0f0',
          200: '#b3c1e1',
          300: '#8da2d2',
          400: '#6683c3',
          500: '#4064b4',
          600: '#1a2e5a',
          700: '#152548',
          800: '#101c36',
          900: '#0b1324',
        },
        gold: {
          50: '#fdf9f0',
          100: '#f9efd4',
          200: '#f3dfa9',
          300: '#edcf7e',
          400: '#e7bf53',
          500: '#c9a84c',
          600: '#a08438',
          700: '#786328',
          800: '#504218',
          900: '#282108',
        },
      },
      fontFamily: {
        serif: ['Georgia', 'Cambria', 'Times New Roman', 'serif'],
        sans: ['Inter', 'system-ui', '-apple-system', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
