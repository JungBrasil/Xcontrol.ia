import React, { useState } from 'react';
import Sidebar from '../components/layout/Sidebar';
import Header from '../components/layout/Header';
// Placeholder para mÃ³dulos para simplificar o script
const Placeholder = ({name}) => <div className="p-8 text-slate-500">MÃ³dulo {name} carregado. (VersÃ£o simplificada para Demo)</div>;

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
