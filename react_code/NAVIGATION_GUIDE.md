# 🗺️ Cherish AI - Complete Navigation Guide

## 📍 How to Access All Pages

### **Starting Point: Home Page**
When you first open the app, you land on:
- **URL:** `/` (root)
- **Page:** Hero Banner Demo
- **Action:** Click "Continue" button → Goes to `/auth`

---

## 🔐 **PUBLIC PAGES** (No Login Required)

### **1. Authentication Flow**
```
/ (Hero Banner) 
  ↓ Click "Continue"
/auth (Login/Sign Up Screen)
  ↓ After Sign Up or Login
/user-type (Choose Individual or Business)
```

**Direct URLs:**
- `/` - Hero Banner Demo (landing page)
- `/auth` - Login/Sign Up Screen
- `/user-type` - Choose Individual or Business User
- `/language-selection` - Select App Language

### **2. Public Onboarding Steps**
These are demo onboarding screens:
- `/initial-splash` - Initial Splash Screen
- `/new-splash` - New Splash Screen
- `/onboarding-step2` - Onboarding Step 2
- `/onboarding-step3` - Onboarding Step 3
- `/onboarding-step4` - Onboarding Step 4
- `/onboarding-step5` - Onboarding Step 5
- `/onboarding-step6` - Onboarding Step 6
- `/onboarding-step7` - Onboarding Step 7
- `/splash` - Original Splash Screen

---

## 💑 **INDIVIDUAL USER PAGES**

### **Access Method:**
1. Go to `/auth` → Sign up/Login
2. Select "Individual" at `/user-type`
3. Complete onboarding or navigate directly to pages below

### **A. Onboarding Flow (8 screens)**
```
/individual/user-info (Your Info)
  ↓
/individual/add-loved-one (Add First Loved One)
  ↓
/individual/your-relationship-goals (Primary Goals)
  ↓
/individual/secondary-goals-context (Secondary Goals)
  ↓
/individual/loved-one-preferences (Their Preferences)
  ↓
/individual/dislikes (Things to Avoid)
  ↓
/individual/subscription (Choose Plan)
  ↓
/individual/checkout (Complete Payment)
  ↓
/individual/home (Main Dashboard)
```

### **B. Main Dashboard & Core Features (8 screens)**

#### **Bottom Navigation (5 main tabs):**
1. 🏠 **Home** - `/individual/home`
   - Main dashboard with upcoming events, AI suggestions, loved ones carousel
   
2. 🔍 **Search** - `/individual/search`
   - Search loved ones, gifts, events, and quick category access
   
3. 💕 **Loved Ones** - `/individual/loved-ones-list`
   - View all loved ones, add new ones, edit/delete
   - Click any loved one → `/individual/loved-one-details/:id`
   
4. 🔔 **Alerts** - `/individual/notifications-list`
   - View all notifications and reminders
   
5. 👤 **Profile** - `/individual/user-profile`
   - Edit profile, view stats, logout

#### **Gift Features (3 screens):**
- `/individual/gifts-hub` - All upcoming events & gift opportunities
- `/individual/gift-ideas/:eventId` - AI gift suggestions for specific event
- `/individual/business-suggestions/:giftId` - Business recommendations for gifts

**How to Access Gift Pages:**
- From Home → Scroll to "Upcoming Events" → Click "View Gift Ideas"
- From Home → Click "Explore All Gifts" button
- From Loved One Details → Click "Get Gift Ideas" button

### **C. Settings Pages (3 screens)**
Access from Profile page:
- `/individual/user-profile` - User Profile & Stats
- `/individual/notifications-privacy` - Notifications & Privacy Settings
- `/individual/contact-us` - Contact Support

---

## 🏢 **BUSINESS USER PAGES**

### **Access Method:**
1. Go to `/auth` → Sign up/Login
2. Select "Business" at `/user-type`
3. Complete business registration or navigate directly

### **Business Flow (6 screens)**
```
/business/splash (Business Welcome)
  ↓
/business/register (Business Registration)
  ↓
/business/products (Add Products/Services)
  ↓
/business/dashboard (Main Business Dashboard)
```

**All Business Pages:**
- `/business/splash` - Business Welcome Screen
- `/business/register` - Register Your Business
- `/business/products` - Product Registration
- `/business/dashboard` - Business Dashboard (Analytics, Products, Leads)
- `/business/profile` - Business Profile Settings
- `/business/subscription` - Business Subscription Plans

---

## 🎯 **QUICK ACCESS GUIDE**

### **To Access Individual Pages:**
Type in browser or click "Continue" from home:
1. `/auth` → Login/Sign Up
2. `/user-type` → Select "Individual"
3. You'll go through onboarding OR
4. Directly visit `/individual/home` if already logged in

### **To Access Business Pages:**
Type in browser or click "Continue" from home:
1. `/auth` → Login/Sign Up
2. `/user-type` → Select "Business"
3. You'll see `/business/splash`
4. Complete registration → `/business/dashboard`

### **Testing Individual Features:**
- **Main Dashboard:** `/individual/home`
- **View Loved Ones:** `/individual/loved-ones-list`
- **Search:** `/individual/search`
- **Notifications:** `/individual/notifications-list`
- **Your Profile:** `/individual/user-profile`
- **All Gifts:** `/individual/gifts-hub`

### **Testing Business Features:**
- **Business Dashboard:** `/business/dashboard`
- **Add Products:** `/business/products`
- **Business Profile:** `/business/profile`
- **Upgrade Plan:** `/business/subscription`

---

## 📱 **BOTTOM NAVIGATION (Individual Users Only)**

The bottom navigation appears on all individual user screens with 5 tabs:

| Icon | Label | Route | Description |
|------|-------|-------|-------------|
| 🏠 | Home | `/individual/home` | Main dashboard |
| 🔍 | Search | `/individual/search` | Search everything |
| 💕 | Loved Ones | `/individual/loved-ones-list` | Manage loved ones |
| 🔔 | Alerts | `/individual/notifications-list` | Notifications |
| 👤 | Profile | `/individual/user-profile` | Your profile |

---

## 🚀 **FASTEST WAY TO TEST EVERYTHING**

### **Method 1: Direct URLs**
Just type these in your browser address bar:
- `/` - Start here
- `/auth` - Login screen
- `/individual/home` - Individual dashboard
- `/business/dashboard` - Business dashboard

### **Method 2: Follow The Flow**
1. Open app → Click "Continue" → Sign up → Select Individual → Complete onboarding
2. You'll land on `/individual/home`
3. Use bottom navigation to explore all features
4. To see business pages, logout and select "Business" user type

---

## 📊 **TOTAL PAGE COUNT: 28+ Screens**

- ✅ Public Pages: 13
- ✅ Individual Onboarding: 8
- ✅ Individual Core: 8
- ✅ Individual Settings: 3
- ✅ Business Pages: 6

**All pages are fully functional and connected!** 🎉
