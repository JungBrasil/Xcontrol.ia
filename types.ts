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
