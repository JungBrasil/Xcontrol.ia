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
