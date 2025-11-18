import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  base: '/',
  define: {
    // Isso permite que o código acesse process.env.API_KEY mesmo no navegador
    'process.env.API_KEY': JSON.stringify(process.env.API_KEY),
  },
});
