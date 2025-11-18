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
    // SimulaÃ§Ã£o para demonstraÃ§Ã£o se a chave nÃ£o estiver configurada no build
    if (!process.env.API_KEY) return { complianceChecklist: [], preliminaryReport: { summary: "Modo Demo: Sem chave API configurada.", attentionPoints: [], inconsistencies: [], recommendations: [] } };

    const fileParts = await Promise.all(files.map(fileToGenerativePart));
    const prompt = "Analise os documentos da fase preparatÃ³ria de uma contrataÃ§Ã£o (Lei 14.133/2021). Retorne JSON.";
    
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
    return "Texto da manifestaÃ§Ã£o melhorado e formalizado pela IA.";
};
