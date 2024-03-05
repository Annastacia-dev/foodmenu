const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
        playfair: ['Playfair Display', 'serif'],
        primary: ['Protest Riot', 'sans-serif'],
        amatic: ['Amatic SC', 'sans-serif']
      },
      colors: {
        'secondary': '#9C4641',
        'primary': '#9A0610',
        'seasalt' : '#f9fafa',
        'offwhite': '#fefefe',
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
