import React from 'react';
import { useAuth } from '../../contexts/AuthContext';
import { resetDemoData } from '../../services/apiService';

const Sidebar = ({ activeModule, setActiveModule }) => {
  const { user, logout } = useAuth();
  const modules = [
    {id:'VisaoGeral', name:'VisÃ£o Geral'}, 
    {id:'Auditoria', name:'Auditoria'},
    {id:'Gabinete', name:'Gabinete'},
    {id:'Corregedoria', name:'Corregedoria'},
    {id:'Ouvidoria', name:'Ouvidoria'},
    {id:'Consolidacao', name:'ConsolidaÃ§Ã£o'}
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
