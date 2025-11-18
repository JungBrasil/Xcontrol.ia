import React from 'react';
const Header = ({ activeModule }) => (
    <header className="h-16 bg-white shadow-sm flex items-center px-6 font-bold text-slate-800">
        MÃ³dulo: {activeModule}
    </header>
);
export default Header;
