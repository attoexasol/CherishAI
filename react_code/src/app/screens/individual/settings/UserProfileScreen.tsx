import { ImageWithFallback } from "../../../components/figma/ImageWithFallback";
import { motion } from "motion/react";
import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import {
  User,
  Mail,
  Phone,
  MapPin,
  Edit2,
  LogOut,
  Heart,
  Gift,
  Eye,
  TrendingUp,
  CreditCard,
  Settings,
} from "lucide-react";
import RomanticCard from "../../../components/RomanticCard";
import RomanticButton from "../../../components/RomanticButton";
import RomanticInput from "../../../components/RomanticInput";
import BottomNav from "../../../components/BottomNav";

export default function UserProfileScreen() {
  const navigate = useNavigate();
  const [isEditing, setIsEditing] = useState(false);
  const [showLogoutModal, setShowLogoutModal] = useState(false);
  const [profile, setProfile] = useState({
    name: "Alex Johnson",
    email: "alex@example.com",
    phone: "+1 (555) 123-4567",
    country: "",
    city: "",
    postalCode: "",
    stateRegion: "",
    streetAddress: "",
    accountType: "Premium",
  });

  // Countries list
  const countries = [
    "United States",
    "Canada",
    "United Kingdom",
    "Australia",
    "Germany",
    "France",
    "Italy",
    "Spain",
    "Japan",
    "China",
    "India",
    "Brazil",
    "Mexico",
    "South Africa",
    "Egypt",
    "Nigeria",
    "United Arab Emirates",
    "Singapore",
    "Malaysia",
    "New Zealand",
    "Netherlands",
    "Belgium",
    "Switzerland",
    "Sweden",
    "Norway",
    "Denmark",
    "Finland",
    "Ireland",
    "Portugal",
    "Greece",
    "Poland",
    "Czech Republic",
    "Austria",
    "Hungary",
    "Romania",
    "South Korea",
    "Thailand",
    "Vietnam",
    "Philippines",
    "Indonesia",
    "Pakistan",
    "Bangladesh",
    "Turkey",
    "Saudi Arabia",
    "Israel",
    "Argentina",
    "Chile",
    "Colombia",
    "Peru",
    "Venezuela",
  ].sort();

  // Load user data from localStorage on component mount
  useEffect(() => {
    const usersJson = localStorage.getItem("cherish_users");
    if (usersJson) {
      try {
        const users = JSON.parse(usersJson);
        const individualUser = users.find(
          (u: any) => u.userType === "individual",
        );

        if (individualUser) {
          setProfile({
            name:
              individualUser.fullName ||
              individualUser.name ||
              "User",
            email: individualUser.email || "user@example.com",
            phone: individualUser.phone || "",
            country: individualUser.country || "",
            city: individualUser.city || "",
            postalCode: individualUser.postalCode || "",
            stateRegion: individualUser.stateRegion || "",
            streetAddress: individualUser.streetAddress || "",
            accountType:
              individualUser.subscription?.planName || "Free",
          });
        }
      } catch (error) {
        console.error("Error loading user data:", error);
      }
    }
  }, []);

  const handleSaveChanges = () => {
    // Save changes to localStorage
    const usersJson = localStorage.getItem("cherish_users");
    if (usersJson) {
      try {
        const users = JSON.parse(usersJson);
        const userIndex = users.findIndex(
          (u: any) => u.userType === "individual",
        );

        if (userIndex !== -1) {
          users[userIndex] = {
            ...users[userIndex],
            name: profile.name,
            fullName: profile.name,
            email: profile.email,
            phone: profile.phone,
            country: profile.country,
            city: profile.city,
            postalCode: profile.postalCode,
            stateRegion: profile.stateRegion,
            streetAddress: profile.streetAddress,
          };
          localStorage.setItem(
            "cherish_users",
            JSON.stringify(users),
          );
        }
      } catch (error) {
        console.error("Error saving user data:", error);
      }
    }
    setIsEditing(false);
  };

  const handleLogout = () => {
    // Clear all user data from localStorage
    localStorage.removeItem("cherish_users");
    localStorage.removeItem("cherish_subscription");
    localStorage.removeItem("cherish_loved_ones");
    localStorage.removeItem("cherish_events");
    localStorage.removeItem("cherish_auth_token");

    // Navigate to auth screen
    navigate("/auth");
  };

  return (
    <div className="min-h-screen pb-24 bg-gradient-to-b from-pink-50/30 to-white">
      {/* Header with Profile Photo */}
      <div className="bg-gradient-to-br from-rose-400 via-pink-400 to-purple-400 px-6 pt-12 pb-20 relative overflow-hidden">
        {/* Decorative elements */}
        <div className="absolute top-0 right-0 w-40 h-40 bg-white/10 rounded-full blur-3xl"></div>
        <div className="absolute bottom-0 left-0 w-32 h-32 bg-white/10 rounded-full blur-2xl"></div>

        <div className="relative">
          <div className="flex items-center justify-between mb-6">
            <h1 className="text-white text-3xl">Profile</h1>
            <button
              onClick={() => setIsEditing(!isEditing)}
              className={`w-10 h-10 rounded-full flex items-center justify-center transition-all duration-300 shadow-lg ${
                isEditing
                  ? "bg-gradient-to-br from-rose-500 to-pink-500 hover:from-rose-600 hover:to-pink-600 scale-110"
                  : "bg-white hover:bg-rose-50 hover:scale-105"
              }`}
            >
              <Edit2
                className={`w-5 h-5 transition-colors ${
                  isEditing ? "text-white" : "text-rose-600"
                }`}
              />
            </button>
          </div>

          {/* Profile Photo */}
          <div className="flex flex-col items-center">
            <div className="relative mb-4">
              <div className="w-24 h-24 rounded-full overflow-hidden border-4 border-white shadow-xl">
                <ImageWithFallback
                  src="https://images.unsplash.com/photo-1749700332038-640b00de758c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxoYXBweSUyMHBlcnNvbiUyMHBvcnRyYWl0fGVufDF8fHx8MTc2ODE1MzI4OHww&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral"
                  alt={profile.name}
                  className="w-full h-full object-cover"
                />
              </div>
              <div className="absolute bottom-0 right-0 w-6 h-6 bg-green-400 rounded-full border-2 border-white"></div>
            </div>
            <h2 className="text-white text-2xl mb-1">
              {profile.name}
            </h2>
            <p className="text-white/90 text-sm flex items-center gap-2">
              <span className="inline-block w-2 h-2 bg-yellow-300 rounded-full"></span>
              {profile.accountType} Member
            </p>
          </div>
        </div>
      </div>

      <div className="px-6 -mt-12 space-y-4">
        {/* Stats Cards */}
        <div className="grid grid-cols-2 gap-3 mb-4">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
          >
            <RomanticCard className="relative overflow-hidden">
              <div className="absolute top-0 right-0 w-16 h-16 bg-rose-100 rounded-full -mr-8 -mt-8"></div>
              <div className="relative">
                <div className="flex items-center gap-2 mb-2">
                  <Eye className="w-4 h-4 text-rose-400" />
                  <span className="text-xs text-gray-600">
                    Loved Ones
                  </span>
                </div>
                <p className="text-2xl text-gray-800">12</p>
                <p className="text-xs text-green-600 mt-1 flex items-center gap-1">
                  <TrendingUp className="w-3 h-3" />
                  +2 this month
                </p>
              </div>
            </RomanticCard>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
          >
            <RomanticCard className="relative overflow-hidden">
              <div className="absolute top-0 right-0 w-16 h-16 bg-pink-100 rounded-full -mr-8 -mt-8"></div>
              <div className="relative">
                <div className="flex items-center gap-2 mb-2">
                  <Heart className="w-4 h-4 text-pink-400" />
                  <span className="text-xs text-gray-600">
                    Moments
                  </span>
                </div>
                <p className="text-2xl text-gray-800">47</p>
                <p className="text-xs text-green-600 mt-1 flex items-center gap-1">
                  <TrendingUp className="w-3 h-3" />
                  +8 this week
                </p>
              </div>
            </RomanticCard>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.3 }}
          >
            <RomanticCard className="relative overflow-hidden">
              <div className="absolute top-0 right-0 w-16 h-16 bg-purple-100 rounded-full -mr-8 -mt-8"></div>
              <div className="relative">
                <div className="flex items-center gap-2 mb-2">
                  <Gift className="w-4 h-4 text-purple-400" />
                  <span className="text-xs text-gray-600">
                    Gifts Sent
                  </span>
                </div>
                <p className="text-2xl text-gray-800">23</p>
                <p className="text-xs text-green-600 mt-1 flex items-center gap-1">
                  <TrendingUp className="w-3 h-3" />
                  +3 this month
                </p>
              </div>
            </RomanticCard>
          </motion.div>
        </div>

        {/* Profile Details Card */}
        <RomanticCard gradient>
          <h3 className="text-gray-800 mb-4 flex items-center gap-2">
            <User className="w-5 h-5 text-rose-400" />
            Personal Information
          </h3>

          {!isEditing ? (
            <div className="space-y-4">
              <div className="flex items-start gap-3">
                <div className="w-10 h-10 rounded-full bg-rose-50 flex items-center justify-center flex-shrink-0">
                  <Mail className="w-5 h-5 text-rose-400" />
                </div>
                <div className="flex-1">
                  <p className="text-xs text-gray-500 mb-1">
                    Email Address
                  </p>
                  <p className="text-gray-800">
                    {profile.email}
                  </p>
                </div>
              </div>
              <div className="flex items-start gap-3">
                <div className="w-10 h-10 rounded-full bg-pink-50 flex items-center justify-center flex-shrink-0">
                  <Phone className="w-5 h-5 text-pink-400" />
                </div>
                <div className="flex-1">
                  <p className="text-xs text-gray-500 mb-1">
                    Phone Number
                  </p>
                  <p className="text-gray-800">
                    {profile.phone}
                  </p>
                </div>
              </div>
              <div className="flex items-start gap-3">
                <div className="w-10 h-10 rounded-full bg-purple-50 flex items-center justify-center flex-shrink-0">
                  <MapPin className="w-5 h-5 text-purple-400" />
                </div>
                <div className="flex-1">
                  <p className="text-xs text-gray-500 mb-1">
                    Location
                  </p>
                  <p className="text-gray-800">
                    {[
                      profile.streetAddress,
                      profile.city,
                      profile.stateRegion,
                      profile.postalCode,
                      profile.country,
                    ]
                      .filter(Boolean)
                      .join(", ") || "No location set"}
                  </p>
                </div>
              </div>
            </div>
          ) : (
            <div className="space-y-3">
              <div>
                <label className="text-xs text-gray-600 mb-1 block">
                  Full Name
                </label>
                <RomanticInput
                  value={profile.name}
                  onChange={(e) =>
                    setProfile({
                      ...profile,
                      name: e.target.value,
                    })
                  }
                />
              </div>
              <div>
                <label className="text-xs text-gray-600 mb-1 block">
                  Email
                </label>
                <RomanticInput
                  value={profile.email}
                  onChange={(e) =>
                    setProfile({
                      ...profile,
                      email: e.target.value,
                    })
                  }
                />
              </div>
              <div>
                <label className="text-xs text-gray-600 mb-1 block">
                  Phone
                </label>
                <RomanticInput
                  value={profile.phone}
                  onChange={(e) =>
                    setProfile({
                      ...profile,
                      phone: e.target.value,
                    })
                  }
                />
              </div>

              {/* Location Section - Match Registration Format */}
              <div className="pt-2">
                <div className="flex items-center gap-2 mb-3">
                  <MapPin className="w-4 h-4 text-rose-400" />
                  <label className="text-xs text-gray-700 font-semibold">
                    Location
                  </label>
                </div>

                {/* Country Dropdown */}
                <div className="mb-3">
                  <RomanticInput
                    mode="select"
                    label="Country"
                    options={[
                      {
                        value: "",
                        label: "Select your country",
                      },
                      ...countries.map((country) => ({
                        value: country,
                        label: country,
                      })),
                    ]}
                    value={profile.country}
                    onChange={(e) =>
                      setProfile({
                        ...profile,
                        country: e.target.value,
                      })
                    }
                  />
                </div>

                {/* City and Postal Code - Side by Side */}
                <div className="grid grid-cols-2 gap-3 mb-3">
                  <div>
                    <label className="text-xs text-gray-600 mb-1 block">
                      City
                    </label>
                    <RomanticInput
                      placeholder="Your city"
                      value={profile.city}
                      onChange={(e) =>
                        setProfile({
                          ...profile,
                          city: e.target.value,
                        })
                      }
                    />
                  </div>
                  <div>
                    <label className="text-xs text-gray-600 mb-1 block">
                      Postal Code
                    </label>
                    <RomanticInput
                      placeholder="Postal code"
                      value={profile.postalCode}
                      onChange={(e) =>
                        setProfile({
                          ...profile,
                          postalCode: e.target.value,
                        })
                      }
                    />
                  </div>
                </div>

                {/* State/Region */}
                <div className="mb-3">
                  <label className="text-xs text-gray-600 mb-1 block">
                    State / Region{" "}
                    <span className="text-gray-400">
                      (Optional)
                    </span>
                  </label>
                  <RomanticInput
                    placeholder="State, province, or region"
                    value={profile.stateRegion}
                    onChange={(e) =>
                      setProfile({
                        ...profile,
                        stateRegion: e.target.value,
                      })
                    }
                  />
                </div>

                {/* Street Address */}
                <div>
                  <label className="text-xs text-gray-600 mb-1 block">
                    Street Address{" "}
                    <span className="text-gray-400">
                      (Optional)
                    </span>
                  </label>
                  <RomanticInput
                    placeholder="123 Main Street, Apt 4B"
                    value={profile.streetAddress}
                    onChange={(e) =>
                      setProfile({
                        ...profile,
                        streetAddress: e.target.value,
                      })
                    }
                  />
                </div>
              </div>

              <RomanticButton
                fullWidth
                onClick={handleSaveChanges}
              >
                Save Changes
              </RomanticButton>
            </div>
          )}
        </RomanticCard>

        {/* Manage Subscription Button */}
        <RomanticCard>
          <motion.button
            onClick={() =>
              navigate("/individual/manage-subscription")
            }
            className="w-full flex items-center justify-center gap-3 py-4 rounded-2xl font-bold relative overflow-hidden group"
            style={{
              background:
                "linear-gradient(135deg, #F5F3FF, #FAF5FF)",
              border: "2px solid #D8B4FE",
              color: "#9333EA",
              boxShadow:
                "0px 4px 16px rgba(216, 180, 254, 0.35)",
            }}
            whileHover={{
              scale: 1.02,
              boxShadow:
                "0px 8px 24px rgba(216, 180, 254, 0.5)",
              background:
                "linear-gradient(135deg, #EDE9FE, #F3E8FF)",
            }}
            whileTap={{ scale: 0.98 }}
            transition={{ duration: 0.2 }}
          >
            {/* Gradient overlay on hover */}
            <motion.div
              className="absolute inset-0 rounded-2xl"
              style={{
                background:
                  "linear-gradient(135deg, rgba(147, 51, 234, 0.08), rgba(216, 180, 254, 0.08))",
                opacity: 0,
              }}
              whileHover={{ opacity: 1 }}
              transition={{ duration: 0.3 }}
            />

            <CreditCard
              className="w-5 h-5 relative z-10 group-hover:scale-110 transition-transform"
              style={{ color: "#9333EA" }}
            />
            <span
              className="font-bold relative z-10"
              style={{ fontSize: "15px", color: "#9333EA" }}
            >
              Manage Subscription
            </span>
          </motion.button>
        </RomanticCard>

        {/* Logout Button */}
        <RomanticCard>
          <motion.button
            onClick={() => setShowLogoutModal(true)}
            className="w-full flex items-center justify-center gap-3 py-4 rounded-2xl font-bold relative overflow-hidden group"
            style={{
              background:
                "linear-gradient(135deg, #FFF5F8, #FFE8F0)",
              border: "2px solid #F6A6C1",
              color: "#D84B7A",
              boxShadow:
                "0px 4px 16px rgba(246, 166, 193, 0.35)",
            }}
            whileHover={{
              scale: 1.02,
              boxShadow:
                "0px 8px 24px rgba(246, 166, 193, 0.5)",
              background:
                "linear-gradient(135deg, #FFE8F0, #FFD4E5)",
            }}
            whileTap={{ scale: 0.98 }}
            transition={{ duration: 0.2 }}
          >
            {/* Gradient overlay on hover */}
            <motion.div
              className="absolute inset-0 rounded-2xl"
              style={{
                background:
                  "linear-gradient(135deg, rgba(216, 75, 122, 0.08), rgba(246, 166, 193, 0.08))",
                opacity: 0,
              }}
              whileHover={{ opacity: 1 }}
              transition={{ duration: 0.3 }}
            />

            <LogOut
              className="w-5 h-5 relative z-10 group-hover:rotate-12 transition-transform"
              style={{ color: "#D84B7A" }}
            />
            <span
              className="font-bold relative z-10"
              style={{ fontSize: "15px", color: "#D84B7A" }}
            >
              Log Out
            </span>
          </motion.button>
        </RomanticCard>
      </div>

      <BottomNav />

      {/* Logout Modal */}
      {showLogoutModal && (
        <div className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 px-6">
          <motion.div
            initial={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            className="bg-white/95 backdrop-blur-xl rounded-3xl shadow-2xl max-w-sm w-full border border-pink-200/50 overflow-hidden"
          >
            {/* Header */}
            <div className="bg-gradient-to-br from-rose-400 via-pink-400 to-purple-400 p-6">
              <div className="flex items-center justify-center w-16 h-16 rounded-full bg-white/20 backdrop-blur-sm mx-auto mb-3">
                <LogOut className="w-8 h-8 text-white" />
              </div>
              <h2 className="text-2xl font-bold text-white text-center">
                Log Out
              </h2>
            </div>

            {/* Content */}
            <div className="p-6">
              <p className="text-gray-600 text-center mb-6">
                Are you sure you want to log out? You'll need to
                sign in again to access your account.
              </p>

              {/* Buttons */}
              <div className="flex gap-3">
                <button
                  onClick={() => setShowLogoutModal(false)}
                  className="flex-1 py-3 px-4 rounded-xl bg-gray-100 hover:bg-gray-200 text-gray-700 font-semibold transition-all"
                >
                  Cancel
                </button>
                <button
                  onClick={handleLogout}
                  className="flex-1 py-3 px-4 rounded-xl bg-gradient-to-r from-rose-500 to-pink-500 hover:from-rose-600 hover:to-pink-600 text-white font-semibold shadow-lg shadow-pink-300/50 transition-all"
                >
                  Log Out
                </button>
              </div>
            </div>
          </motion.div>
        </div>
      )}
    </div>
  );
}