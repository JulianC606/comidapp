const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
  ],
  theme: {
    extend: {
      colors: ({ colors }) => ({
        primary: {
          DEFAULT: "#C34A5E",
          50: "#F1D4D9",
          100: "#ECC5CB",
          200: "#E1A6B0",
          300: "#D78795",
          400: "#CD6979",
          500: "#C34A5E",
          600: "#A03547",
          700: "#762734",
          800: "#4C1921",
          900: "#210B0F",
          950: "#0C0405",
        },
        danger: colors.red,
        warning: colors.yellow,
        success: {
          DEFAULT: '#9EA544',
          50: '#EEF0DA',
          100: '#E8EACB',
          200: '#DADEAE',
          300: '#CDD292',
          400: '#C0C675',
          500: '#B3BA58',
          600: '#9EA544',
          700: '#787D34',
          800: '#525623',
          900: '#2C2E13',
          950: '#191A0B'
        },
        info: {
          DEFAULT: "#C34A5E",
          50: "#F1D4D9",
          100: "#ECC5CB",
          200: "#E1A6B0",
          300: "#D78795",
          400: "#CD6979",
          500: "#C34A5E",
          600: "#A03547",
          700: "#762734",
          800: "#4C1921",
          900: "#210B0F",
          950: "#0C0405",
        },
        gray: {
          DEFAULT: '#697B8D',
          50: '#E8EBEE',
          100: '#DDE1E5',
          200: '#C5CDD4',
          300: '#AEB8C3',
          400: '#96A4B1',
          500: '#7F8FA0',
          600: '#697B8D',
          700: '#515F6D',
          800: '#39434D',
          900: '#21272D',
          950: '#15191C'
        },
      }),
    },
    fontFamily: {
      sans: ["Inter var", ...defaultTheme.fontFamily.sans],
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};
