# Script para gerar o projeto XControl.ia no Windows
# Autor: XControl.ia Generator

$baseDir = "$HOME\Desktop\XControl"
Write-Host "Criando projeto em: $baseDir" -ForegroundColor Cyan

# Criar estrutura de pastas
New-Item -ItemType Directory -Force -Path "$baseDir" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir\components\auth" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir\components\auditoria" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir\components\gabinete" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir\components\corregedoria" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir\components\ouvidoria" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir\components\consolidacao" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir\components\dashboard" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir\components\layout" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir\components\shared" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir\components\icons" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir\contexts" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir\pages" | Out-Null
New-Item -ItemType Directory -Force -Path "$baseDir\services" | Out-Null

# Função auxiliar para criar arquivos
function New-FileContent {
    param ($Path, $Content)
    $FullPath = Join-Path $baseDir $Path
    Set-Content -Path $FullPath -Value $Content -Encoding UTF8
    Write-Host "Criado: $Path" -ForegroundColor Green
}

# --- ARQUIVOS DE CONFIGURAÇÃO ---

New-FileContent "package.json" @'
{
  "name": "xcontrol-ia",
  "private": true,
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "@google/genai": "^0.1.1",
    "clsx": "^2.1.0",
    "tailwind-merge": "^2.2.1"
  },
  "devDependencies": {
    "@types/react": "^18.2.66",
    "@types/react-dom": "^18.2.22",
    "@vitejs/plugin-react": "^4.2.1",
    "autoprefixer": "^10.4.19",
    "postcss": "^8.4.38",
    "tailwindcss": "^3.4.3",
    "typescript": "^5.2.2",
    "vite": "^5.2.0"
  }
}
'@

New-FileContent "vite.config.ts" @'
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  define: {
    'process.env.API_KEY': JSON.stringify(process.env.API_KEY),
  },
});
'@

New-FileContent "tsconfig.json" @'
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": false,
    "noUnusedParameters": false,
    "noFallthroughCasesInSwitch": true
  },
  "include": ["**/*.ts", "**/*.tsx"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
'@

New-FileContent "tsconfig.node.json" @'
{
  "compilerOptions": {
    "composite": true,
    "skipLibCheck": true,
    "module": "ESNext",
    "moduleResolution": "bundler",
    "allowSyntheticDefaultImports": true
  },
  "include": ["vite.config.ts"]
}
'@

New-FileContent "tailwind.config.js" @'
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
'@

New-FileContent "postcss.config.js" @'
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
'@

New-FileContent "vite-env.d.ts" @'
/// <reference types="vite/client" />
'@

New-FileContent "vercel.json" @'
{
  "rewrites": [{ "source": "/(.*)", "destination": "/index.html" }]
}
'@

New-FileContent ".gitignore" @'
node_modules
dist
.env
.DS_Store
'@

New-FileContent "index.html" @'
<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="Sistema oficial de controle interno, auditoria e transparência governamental baseada em Inteligência Artificial." />
    <meta name="theme-color" content="#1e293b" />
    <title>XControl.ia - Controle Inteligente para Gestão Pública</title>
  </head>
  <body class="bg-slate-100 text-slate-900 antialiased">
    <div id="root"></div>
    <script type="module" src="/index.tsx"></script>
  </body>
</html>
'@

New-FileContent "index.css" @'
@tailwind base;
@tailwind components;
@tailwind utilities;

::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}
::-webkit-scrollbar-track {
  background: #f1f5f9;
}
::-webkit-scrollbar-thumb {
  background: #94a3b8;
  border-radius: 10px;
}
::-webkit-scrollbar-thumb:hover {
  background: #64748b;
}
.animate-fade-in {
  animation: fadeIn 0.5s ease-out;
}
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}
'@

New-FileContent "index.tsx" @'
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css';

const rootElement = document.getElementById('root');
if (!rootElement) {
  throw new Error("Could not find root element to mount to");
}

const root = ReactDOM.createRoot(rootElement);
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
'@

New-FileContent "App.tsx" @'
import React from 'react';
import { AuthProvider, useAuth } from './contexts/AuthContext';
import LoginPage from './pages/LoginPage';
import DashboardPage from './pages/DashboardPage';

const AppContent: React.FC = () => {
  const { isAuthenticated } = useAuth();
  if (!isAuthenticated) {
    return <LoginPage />;
  }
  return <DashboardPage />;
};

const App: React.FC = () => {
  return (
    <AuthProvider>
      <AppContent />
    </AuthProvider>
  );
};
export default App;
'@

New-FileContent "types.ts" @'
export type ModuleType = 'VisaoGeral' | 'Gabinete' | 'Auditoria' | 'Corregedoria' | 'Ouvidoria' | 'Consolidacao';

export interface User {
  id: string;
  name: string;
  email: string;
  role: string;
  avatarUrl: string;
}

export interface FileMetadata {
    name: string;
    size: number;
    type: string;
}

export interface HistoryItem {
  id: string;
  date: string;
  files: FileMetadata[];
  status: 'processing' | 'completed' | 'error';
  analysisResult?: any;
  error?: string;
  userId: string;
  userName: string;
}

export interface PartnershipHistoryItem extends HistoryItem {}
'@

# --- CONTEXTS ---
New-FileContent "contexts\AuthContext.tsx" @'
import React, { createContext, useState, useContext, useEffect, ReactNode } from 'react';
import { User } from '../types';

interface AuthContextType {
  isAuthenticated: boolean;
  user: User | null;
  login: (email: string, pass: string) => Promise<void>;
  logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

const defaultMockUser: User = {
    id: 'user-001',
    name: 'Auditor Chefe',
    email: 'auditor@cgm.ms.gov.br',
    role: 'Controladoria Geral',
    avatarUrl: 'https://ui-avatars.com/api/?name=Auditor+Chefe&background=0EA5E9&color=fff',
};

export const AuthProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);

  useEffect(() => {
    const storedUser = localStorage.getItem('xcontrol-user');
    if (storedUser) {
        try {
            setUser(JSON.parse(storedUser));
        } catch (e) {
            localStorage.removeItem('xcontrol-user');
        }
    }
  }, []);

  const login = async (email: string, pass: string): Promise<void> => {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            if ((email === 'auditor@cgm.ms.gov.br' && pass === 'password') || 
                (email.endsWith('.gov.br') && pass === 'demo')) {
                
                const userToSave = email === 'auditor@cgm.ms.gov.br' ? defaultMockUser : {
                    id: `user-${Date.now()}`,
                    name: email.split('@')[0].toUpperCase(),
                    email: email,
                    role: 'Visitante Governamental',
                    avatarUrl: `https://ui-avatars.com/api/?name=${email.split('@')[0]}&background=0f172a&color=fff`
                };

                localStorage.setItem('xcontrol-user', JSON.stringify(userToSave));
                setUser(userToSave);
                resolve();
            } else {
                reject(new Error('Credenciais inválidas.'));
            }
        }, 800);
    });
  };

  const logout = () => {
    localStorage.removeItem('xcontrol-user');
    setUser(null);
  };

  return (
    <AuthContext.Provider value={{ isAuthenticated: !!user, user, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = (): AuthContextType => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
'@

# --- SERVICES ---
New-FileContent "services\geminiService.ts" @'
import { GoogleGenAI } from '@google/genai';

const ai = new GoogleGenAI({apiKey: process.env.API_KEY});

export const fileToGenerativePart = async (file: File) => {
  return new Promise((resolve) => {
    const reader = new FileReader();
    reader.onloadend = () => resolve({ inlineData: { mimeType: file.type, data: reader.result.split(',')[1] } });
    reader.readAsDataURL(file);
  });
};

export const analyzeContractDocuments = async (files: File[]) => {
    // Simulação para demonstração se a chave não estiver configurada no build
    if (!process.env.API_KEY) return { complianceChecklist: [], preliminaryReport: { summary: "Modo Demo: Sem chave API configurada.", attentionPoints: [], inconsistencies: [], recommendations: [] } };

    const fileParts = await Promise.all(files.map(fileToGenerativePart));
    const prompt = "Analise os documentos da fase preparatória de uma contratação (Lei 14.133/2021). Retorne JSON.";
    
    try {
        const response = await ai.models.generateContent({
            model: 'gemini-2.5-pro',
            contents: { parts: [ { text: prompt }, ...fileParts ] },
            config: { responseMimeType: 'application/json' }
        });
        return JSON.parse(response.text.trim());
    } catch (e) {
        console.error(e);
        throw new Error("Falha na IA");
    }
};

export const analyzePartnershipDocuments = async (files: File[]) => {
     if (!process.env.API_KEY) return { complianceChecklist: [], formalizationReport: { summary: "Modo Demo", extractedGoals: [], extractedIndicators: [], budgetConsistency: "N/A", recommendations: [] } };
    const fileParts = await Promise.all(files.map(fileToGenerativePart));
    const prompt = "Analise documentos de parceria Terceiro Setor. Retorne JSON.";
    try {
        const response = await ai.models.generateContent({
            model: 'gemini-2.5-pro',
            contents: { parts: [{ text: prompt }, ...fileParts] },
            config: { responseMimeType: 'application/json' }
        });
        return JSON.parse(response.text.trim());
    } catch (e) { throw new Error("Falha na IA"); }
};

export const summarizeDocument = async (file: File) => {
    return "Resumo simulado do documento normativo.";
};

export const improveManifestationText = async (text: string) => {
    return "Texto da manifestação melhorado e formalizado pela IA.";
};
'@

New-FileContent "services\apiService.ts" @'
import { analyzeContractDocuments, analyzePartnershipDocuments } from './geminiService';

const CONTRACT_HISTORY_KEY = 'xcontrol-analysis-history';
const PARTNERSHIP_HISTORY_KEY = 'xcontrol-partnership-history';

export const resetDemoData = () => {
    localStorage.removeItem(CONTRACT_HISTORY_KEY);
    localStorage.removeItem(PARTNERSHIP_HISTORY_KEY);
};

export const getContractAnalysisHistory = async () => {
    const stored = localStorage.getItem(CONTRACT_HISTORY_KEY);
    return stored ? JSON.parse(stored) : [];
};

export const createContractAnalysis = async (userId, userName, fileMetadata, files) => {
    const newItem = {
        id: `analysis-${Date.now()}`,
        date: new Date().toISOString(),
        files: fileMetadata,
        status: 'processing',
        userId, userName
    };
    const history = await getContractAnalysisHistory();
    localStorage.setItem(CONTRACT_HISTORY_KEY, JSON.stringify([newItem, ...history]));
    
    setTimeout(async () => {
        try {
            const result = await analyzeContractDocuments(files);
            const updated = { ...newItem, status: 'completed', analysisResult: result };
            const current = await getContractAnalysisHistory();
            const newHistory = current.map(i => i.id === newItem.id ? updated : i);
            localStorage.setItem(CONTRACT_HISTORY_KEY, JSON.stringify(newHistory));
        } catch(e) {
            console.error(e);
        }
    }, 2000);
    return newItem;
};

export const getPartnershipAnalysisHistory = async () => {
    const stored = localStorage.getItem(PARTNERSHIP_HISTORY_KEY);
    return stored ? JSON.parse(stored) : [];
};

export const createPartnershipAnalysis = async (userId, userName, fileMetadata, files) => {
    const newItem = {
        id: `partnership-${Date.now()}`,
        date: new Date().toISOString(),
        files: fileMetadata,
        status: 'processing',
        userId, userName
    };
    const history = await getPartnershipAnalysisHistory();
    localStorage.setItem(PARTNERSHIP_HISTORY_KEY, JSON.stringify([newItem, ...history]));
    
    setTimeout(async () => {
        try {
            const result = await analyzePartnershipDocuments(files);
            const updated = { ...newItem, status: 'completed', analysisResult: result };
            const current = await getPartnershipAnalysisHistory();
            const newHistory = current.map(i => i.id === newItem.id ? updated : i);
            localStorage.setItem(PARTNERSHIP_HISTORY_KEY, JSON.stringify(newHistory));
        } catch(e) { console.error(e); }
    }, 2000);
    return newItem;
};
'@

# --- COMPONENTS MÍNIMOS PARA RODAR ---
# Vou criar apenas os arquivos essenciais para a tela de login e dashboard carregarem.

New-FileContent "components\layout\Sidebar.tsx" @'
import React from 'react';
import { useAuth } from '../../contexts/AuthContext';
import { resetDemoData } from '../../services/apiService';

const Sidebar = ({ activeModule, setActiveModule }) => {
  const { user, logout } = useAuth();
  const modules = [
    {id:'VisaoGeral', name:'Visão Geral'}, 
    {id:'Auditoria', name:'Auditoria'},
    {id:'Gabinete', name:'Gabinete'},
    {id:'Corregedoria', name:'Corregedoria'},
    {id:'Ouvidoria', name:'Ouvidoria'},
    {id:'Consolidacao', name:'Consolidação'}
  ];

  return (
    <nav className="w-64 bg-slate-900 text-white flex flex-col h-full">
      <div className="p-4 border-b border-slate-800 font-bold text-xl">XControl.ia</div>
      <div className="flex-1 p-2 space-y-1">
        {modules.map(m => (
            <button key={m.id} onClick={() => setActiveModule(m.id)} 
            className={`w-full text-left p-3 rounded ${activeModule === m.id ? "bg-sky-600" : "hover:bg-slate-800"}`}>
            {m.name}
            </button>
        ))}
      </div>
      <div className="p-4 border-t border-slate-800">
        <p className="text-xs text-slate-400">{user?.name}</p>
        <button onClick={logout} className="text-red-400 text-sm mt-2">Sair</button>
        <button onClick={() => {resetDemoData(); window.location.reload()}} className="text-yellow-400 text-xs mt-4 w-full border border-dashed border-yellow-600 p-1 rounded">Reset Demo</button>
      </div>
    </nav>
  );
};
export default Sidebar;
'@

New-FileContent "components\layout\Header.tsx" @'
import React from 'react';
const Header = ({ activeModule }) => (
    <header className="h-16 bg-white shadow-sm flex items-center px-6 font-bold text-slate-800">
        Módulo: {activeModule}
    </header>
);
export default Header;
'@

New-FileContent "components\auth\LoginForm.tsx" @'
import React, { useState } from 'react';
import { useAuth } from '../../contexts/AuthContext';

const LoginForm = () => {
  const { login } = useAuth();
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    await login('auditor@cgm.ms.gov.br', 'password');
    setLoading(false);
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4 w-full">
      <div>
        <label className="block text-sm font-medium">Email (Use: auditor@cgm.ms.gov.br)</label>
        <input type="email" value="auditor@cgm.ms.gov.br" readOnly className="w-full p-2 border rounded bg-slate-100"/>
      </div>
      <div>
        <label className="block text-sm font-medium">Senha (Use: password)</label>
        <input type="password" value="password" readOnly className="w-full p-2 border rounded bg-slate-100"/>
      </div>
      <button disabled={loading} className="w-full bg-sky-600 text-white p-2 rounded hover:bg-sky-700">
        {loading ? 'Entrando...' : 'Entrar no Sistema'}
      </button>
    </form>
  );
};
export default LoginForm;
'@

New-FileContent "pages\LoginPage.tsx" @'
import React from 'react';
import LoginForm from '../components/auth/LoginForm';
const LoginPage = () => (
    <div className="h-screen flex items-center justify-center bg-slate-100">
        <div className="bg-white p-8 rounded-lg shadow-lg w-96">
            <h1 className="text-2xl font-bold text-center mb-6 text-slate-800">XControl.ia</h1>
            <LoginForm />
        </div>
    </div>
);
export default LoginPage;
'@

New-FileContent "pages\DashboardPage.tsx" @'
import React, { useState } from 'react';
import Sidebar from '../components/layout/Sidebar';
import Header from '../components/layout/Header';
// Placeholder para módulos para simplificar o script
const Placeholder = ({name}) => <div className="p-8 text-slate-500">Módulo {name} carregado. (Versão simplificada para Demo)</div>;

const DashboardPage = () => {
  const [activeModule, setActiveModule] = useState('VisaoGeral');
  return (
    <div className="flex h-screen bg-slate-100">
      <Sidebar activeModule={activeModule} setActiveModule={setActiveModule} />
      <div className="flex-1 flex flex-col">
        <Header activeModule={activeModule} />
        <main className="flex-1 overflow-auto">
            <Placeholder name={activeModule} />
        </main>
      </div>
    </div>
  );
};
export default DashboardPage;
'@

# --- FIM DO SCRIPT ---
Write-Host "Projeto criado com sucesso na Área de Trabalho (Pasta XControl)!" -ForegroundColor Green
Read-Host "Pressione Enter para sair..."