const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  safelist: [
    'text-red-800',
    'text-green-800',
    'text-orange-800',
    'text-slate-800',
    'border-red-500',
    'border-green-500',
    'border-orange-500',
    'border-slate-500',
    'bg-red-500',
    'bg-green-500',
    'bg-orange-500',
    'bg-slate-500'
  ],
  theme: {
    screens: {
      sm: '480px',
      md: '768px',
      lg: '976px',
      xl: '1440px',
    },
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
