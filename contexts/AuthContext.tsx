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
                reject(new Error('Credenciais invÃ¡lidas.'));
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
