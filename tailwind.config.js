/** @type {import('tailwindcss').Config} */
export default {
  darkMode: 'class',
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        eleven: {
          50: '#eefcf3',
          100: '#d6f7e0',
          200: '#aeeec3',
          300: '#79e0a1',
          400: '#43cb7c',
          500: '#20b060',
          600: '#148f4c',
          700: '#12723f',
          800: '#125a35',
          900: '#104a2d',
        },
        night: {
          950: '#06090a',
          900: '#0b0f11',
          800: '#12181b',
          700: '#1a2226',
        },
      },
      fontFamily: {
        sans: ['Inter', 'Cairo', 'system-ui', 'sans-serif'],
        mono: ['"JetBrains Mono"', 'monospace'],
      },
      animation: {
        float: 'float 6s ease-in-out infinite',
        glow: 'glow 3s ease-in-out infinite',
      },
      keyframes: {
        float: {
          '0%, 100%': { transform: 'translateY(0px)' },
          '50%': { transform: 'translateY(-14px)' },
        },
        glow: {
          '0%, 100%': { opacity: 0.5 },
          '50%': { opacity: 1 },
        },
      },
    },
  },
  plugins: [],
}
