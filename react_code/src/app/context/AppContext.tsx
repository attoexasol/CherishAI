import React, { createContext, useContext, useState, ReactNode, useEffect } from 'react';

interface LovedOne {
  id: string;
  name: string;
  relationship: string;
  photo?: string;
  birthday?: string;
  anniversary?: string;
  hobbies?: string[];
  preferences?: any;
  personalNote?: string;
}

interface User {
  id: string;
  email: string;
  name?: string;
  userType?: 'individual' | 'business';
  isNewUser: boolean;
  onboardingCompleted?: boolean;
}

interface AppContextType {
  userType: 'individual' | 'business' | null;
  setUserType: (type: 'individual' | 'business' | null) => void;
  lovedOnes: LovedOne[];
  addLovedOne: (lovedOne: LovedOne) => void;
  currentUser: User | null;
  setCurrentUser: (user: User | null) => void;
  isAuthenticated: boolean;
  setIsAuthenticated: (isAuth: boolean) => void;
  login: (email: string, password: string) => Promise<User>;
  signUp: (email: string, password: string) => Promise<User>;
  oauthLogin: (email: string) => Promise<User>;
}

const AppContext = createContext<AppContextType | undefined>(undefined);

export function AppProvider({ children }: { children: ReactNode }) {
  const [userType, setUserType] = useState<'individual' | 'business' | null>(null);
  const [lovedOnes, setLovedOnes] = useState<LovedOne[]>([]);
  const [currentUser, setCurrentUser] = useState<User | null>(null);
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  // Clear all localStorage data on component mount (page refresh)
  useEffect(() => {
    // Clear all Cherish AI related data
    const keysToRemove = [
      'cherish_users',
      'cherish_regenerate_usage',
      'cherish_current_user',
      'cherish_user_type',
      'cherish_loved_ones',
      'cherish_subscription',
      'cherish_business_data'
    ];
    
    keysToRemove.forEach(key => {
      localStorage.removeItem(key);
    });

    // Reset all state
    setUserType(null);
    setLovedOnes([]);
    setCurrentUser(null);
    setIsAuthenticated(false);
  }, []); // Empty dependency array = runs once on mount

  const addLovedOne = (lovedOne: LovedOne) => {
    setLovedOnes(prev => [...prev, lovedOne]);
  };

  // Simulated login function - checks if user exists in localStorage
  const login = async (email: string, password: string): Promise<User> => {
    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 1000));

    // Check localStorage for existing user
    const existingUsersJson = localStorage.getItem('cherish_users');
    const existingUsers = existingUsersJson ? JSON.parse(existingUsersJson) : [];
    
    const user = existingUsers.find((u: any) => u.email === email && u.password === password);
    
    if (user) {
      // Returning user
      const userData: User = {
        id: user.id,
        email: user.email,
        name: user.name,
        userType: user.userType,
        isNewUser: false,
        onboardingCompleted: user.onboardingCompleted || false,
      };
      
      setCurrentUser(userData);
      setIsAuthenticated(true);
      setUserType(user.userType);
      
      return userData;
    } else {
      throw new Error('Invalid email or password');
    }
  };

  // Simulated signup function - creates new user in localStorage
  const signUp = async (email: string, password: string): Promise<User> => {
    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 1000));

    // Check if user already exists
    const existingUsersJson = localStorage.getItem('cherish_users');
    const existingUsers = existingUsersJson ? JSON.parse(existingUsersJson) : [];
    
    const userExists = existingUsers.find((u: any) => u.email === email);
    
    if (userExists) {
      throw new Error('User already exists. Please login instead.');
    }

    // Create new user
    const newUser: User = {
      id: Date.now().toString(),
      email,
      isNewUser: true,
    };

    // Store in localStorage (without userType yet - will be set in UserTypeScreen)
    existingUsers.push({
      id: newUser.id,
      email,
      password, // In real app, this would be hashed
      isNewUser: true,
    });
    
    localStorage.setItem('cherish_users', JSON.stringify(existingUsers));
    
    setCurrentUser(newUser);
    setIsAuthenticated(true);
    
    return newUser;
  };

  // Simulated OAuth login - can return new or existing user
  const oauthLogin = async (email: string): Promise<User> => {
    // Simulate OAuth flow delay
    await new Promise(resolve => setTimeout(resolve, 800));

    const existingUsersJson = localStorage.getItem('cherish_users');
    const existingUsers = existingUsersJson ? JSON.parse(existingUsersJson) : [];
    
    // Check if user with this email already exists
    let user = existingUsers.find((u: any) => u.email === email);
    
    if (user) {
      // Returning OAuth user
      const userData: User = {
        id: user.id,
        email: user.email,
        name: user.name,
        userType: user.userType,
        isNewUser: false,
        onboardingCompleted: user.onboardingCompleted || false,
      };
      
      setCurrentUser(userData);
      setIsAuthenticated(true);
      setUserType(user.userType);
      
      return userData;
    } else {
      // New OAuth user
      const newUser: User = {
        id: Date.now().toString(),
        email,
        isNewUser: true,
      };

      existingUsers.push({
        id: newUser.id,
        email,
        isNewUser: true,
      });
      
      localStorage.setItem('cherish_users', JSON.stringify(existingUsers));
      
      setCurrentUser(newUser);
      setIsAuthenticated(true);
      
      return newUser;
    }
  };

  return (
    <AppContext.Provider
      value={{
        userType,
        setUserType,
        lovedOnes,
        addLovedOne,
        currentUser,
        setCurrentUser,
        isAuthenticated,
        setIsAuthenticated,
        login,
        signUp,
        oauthLogin,
      }}
    >
      {children}
    </AppContext.Provider>
  );
}

export function useApp() {
  const context = useContext(AppContext);
  if (!context) {
    throw new Error('useApp must be used within AppProvider');
  }
  return context;
}