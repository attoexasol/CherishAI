import { createContext, useContext, useState, ReactNode } from 'react';

export interface Site {
  id: string;
  locationName: string;
  country: string;
  city: string;
  postalCode: string;
  region: string;
  streetAddress: string;
  contactPerson: string;
  email?: string;
  tel?: string;
  category: string;
  description: string;
  priceRange: number;
  hours: string;
  deliveryType: string[];
  businessImage?: string;
  // Legacy fields for backward compatibility
  address?: string;
  phone?: string;
}

interface BusinessInfo {
  businessName: string;
  category: string;
  contactPersonName: string;
  email: string;
  // Business Location 1
  country: string;
  city: string;
  postalCode: string;
  stateRegion: string;
  streetAddress: string;
  tel: string;
  website: string;
  description: string;
  priceRange: number | string;
  hours: string;
  deliveryType: string | string[];
  businessImage?: string; // Logo/photo URL or base64
  // Social Media
  facebook: string;
  instagram: string;
  tiktok: string;
  whatsapp: string;
  telegram: string;
  reddit: string;
  snapchat: string;
  sites: Site[];
  // Legacy fields for backward compatibility
  address?: string;
  phone?: string;
  youtube?: string;
  x?: string;
}

interface BusinessContextType {
  business: BusinessInfo;
  setBusiness: (info: BusinessInfo) => void;
}

const defaultBusiness: BusinessInfo = {
  businessName: '',
  category: '',
  contactPersonName: '',
  email: '',
  country: '',
  city: '',
  postalCode: '',
  stateRegion: '',
  streetAddress: '',
  tel: '',
  website: '',
  description: '',
  priceRange: 2,
  hours: '',
  deliveryType: [],
  facebook: '',
  instagram: '',
  tiktok: '',
  whatsapp: '',
  telegram: '',
  reddit: '',
  snapchat: '',
  sites: [],
};

const BusinessContext = createContext<BusinessContextType | undefined>(undefined);

export function BusinessProvider({ children }: { children: ReactNode }) {
  const [business, setBusiness] = useState<BusinessInfo>(defaultBusiness);

  return (
    <BusinessContext.Provider value={{
      business,
      setBusiness,
    }}>
      {children}
    </BusinessContext.Provider>
  );
}

export function useBusiness() {
  const context = useContext(BusinessContext);
  if (context === undefined) {
    throw new Error('useBusiness must be used within a BusinessProvider');
  }
  return context;
}