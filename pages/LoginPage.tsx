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
