import { createContext, useContext, useState, ReactNode } from 'react';

type SubscriptionTier = 'basic' | 'plus';

interface SubscriptionLimits {
  maxLocations: number;
  maxProducts: number;
  analytics: 'basic' | 'standard';
}

interface SubscriptionContextType {
  tier: SubscriptionTier;
  limits: SubscriptionLimits;
  upgradeTier: (newTier: SubscriptionTier) => void;
  canAddLocation: (currentCount: number) => boolean;
  canAddProduct: (currentCount: number) => boolean;
}

const SubscriptionContext = createContext<SubscriptionContextType | undefined>(undefined);

const SUBSCRIPTION_LIMITS: Record<SubscriptionTier, SubscriptionLimits> = {
  basic: {
    maxLocations: 1,
    maxProducts: 15,
    analytics: 'basic',
  },
  plus: {
    maxLocations: 7,
    maxProducts: 130,
    analytics: 'standard',
  },
};

export function SubscriptionProvider({ children }: { children: ReactNode }) {
  const [tier, setTier] = useState<SubscriptionTier>('basic');

  const limits = SUBSCRIPTION_LIMITS[tier];

  const upgradeTier = (newTier: SubscriptionTier) => {
    setTier(newTier);
  };

  const canAddLocation = (currentCount: number) => {
    return currentCount < limits.maxLocations;
  };

  const canAddProduct = (currentCount: number) => {
    return currentCount < limits.maxProducts;
  };

  return (
    <SubscriptionContext.Provider
      value={{
        tier,
        limits,
        upgradeTier,
        canAddLocation,
        canAddProduct,
      }}
    >
      {children}
    </SubscriptionContext.Provider>
  );
}

export function useSubscription() {
  const context = useContext(SubscriptionContext);
  if (context === undefined) {
    throw new Error('useSubscription must be used within a SubscriptionProvider');
  }
  return context;
}