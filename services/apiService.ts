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
