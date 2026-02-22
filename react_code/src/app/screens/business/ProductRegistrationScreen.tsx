import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router';
import { Plus, Edit, Trash2, MapPin, Package, Upload, X, Lock, ArrowLeft } from 'lucide-react';
import RomanticCard from '../../components/RomanticCard';
import RomanticButton from '../../components/RomanticButton';
import RomanticInput from '../../components/RomanticInput';
import { motion, AnimatePresence } from 'motion/react';
import { useSubscription } from '../../contexts/SubscriptionContext';
import { useBusiness } from '../../contexts/BusinessContext';

interface Product {
  id: string;
  name: string;
  description: string;
  priceMin: number;
  priceMax: number;
  category: string;
  tags: string[];
  siteId?: string;
  images?: string[];
}

const TAGS = [
  'Birthday', 'Anniversary', 'Wedding', 'Valentine\'s Day', 
  'Mother\'s Day', 'Father\'s Day', 'Graduation', 'Thank You',
  'Just Because', 'Apology', 'Congratulations', 'Get Well'
];

const CATEGORIES = [
  { value: 'gifts', label: 'Gifts & Personalized Items', icon: '🎁' },
  { value: 'food', label: 'Food & Dining Experiences', icon: '🍽️' },
  { value: 'wellness', label: 'Wellness & Self-Care Services', icon: '💆' },
  { value: 'entertainment', label: 'Entertainment & Leisure', icon: '🎭' },
  { value: 'fashion', label: 'Fashion & Style', icon: '👗' },
  { value: 'home', label: 'Home & Lifestyle', icon: '🏠' },
  { value: 'travel', label: 'Travel & Getaways', icon: '✈️' },
  { value: 'memories', label: 'Memories & Creative Services', icon: '📸' },
  { value: 'family', label: 'Family & Children Services', icon: '👨‍👩‍👧' },
  { value: 'learning', label: 'Learning & Personal Growth', icon: '📚' },
];

export default function ProductRegistrationScreen() {
  const navigate = useNavigate();
  const { canAddProduct, limits, tier } = useSubscription();
  const { business } = useBusiness();
  const [products, setProducts] = useState<Product[]>([]);
  const [isOpen, setIsOpen] = useState(false);
  const [editingProduct, setEditingProduct] = useState<Product | null>(null);
  const [productForm, setProductForm] = useState({
    name: '',
    description: '',
    priceMin: 50,
    priceMax: 100,
    category: '',
    tags: [] as string[],
    siteId: '',
    images: [] as string[],
  });

  // Get current user email
  const getCurrentUserEmail = () => {
    const currentUserJson = localStorage.getItem('cherish_current_user');
    if (currentUserJson) {
      const currentUser = JSON.parse(currentUserJson);
      return currentUser.email;
    }
    return null;
  };

  // Load products from localStorage on mount
  useEffect(() => {
    const userEmail = getCurrentUserEmail();
    if (userEmail) {
      const productsKey = `cherish_products_${userEmail}`;
      const savedProducts = localStorage.getItem(productsKey);
      if (savedProducts) {
        setProducts(JSON.parse(savedProducts));
      }
    }
  }, []);

  // Save products to localStorage whenever they change
  useEffect(() => {
    const userEmail = getCurrentUserEmail();
    if (userEmail) {
      const productsKey = `cherish_products_${userEmail}`;
      localStorage.setItem(productsKey, JSON.stringify(products));
    }
  }, [products]);

  // Get sites from business context - include main address + additional sites
  const sites = [
    { 
      id: 'main', 
      locationName: 'Main Location',
      address: `${business.streetAddress ? business.streetAddress + ', ' : ''}${business.city || ''}${business.country ? ', ' + business.country : ''}`.trim() || 'Main Location'
    },
    ...business.sites.map(site => ({ 
      id: site.id, 
      locationName: site.locationName,
      address: `${site.streetAddress ? site.streetAddress + ', ' : ''}${site.city || ''}${site.country ? ', ' + site.country : ''}`.trim() || site.locationName
    }))
  ];

  const hasMutipleSites = sites.length > 1;

  const handleAddProduct = () => {
    if (productForm.name.trim() && productForm.description.trim() && productForm.category && productForm.siteId) {
      if (editingProduct) {
        // Update existing product
        setProducts(products.map(p => 
          p.id === editingProduct.id 
            ? {
                ...editingProduct,
                name: productForm.name,
                description: productForm.description,
                priceMin: productForm.priceMin,
                priceMax: productForm.priceMax,
                category: productForm.category,
                tags: productForm.tags,
                siteId: productForm.siteId || undefined,
                images: productForm.images,
              }
            : p
        ));
        setEditingProduct(null);
      } else {
        // Add new product
        const newProduct: Product = {
          id: Date.now().toString(),
          name: productForm.name,
          description: productForm.description,
          priceMin: productForm.priceMin,
          priceMax: productForm.priceMax,
          category: productForm.category,
          tags: productForm.tags,
          siteId: productForm.siteId || undefined,
          images: productForm.images,
        };
        setProducts([...products, newProduct]);
      }
      setProductForm({ name: '', description: '', priceMin: 50, priceMax: 100, category: '', tags: [], siteId: '', images: [] });
      setIsOpen(false);
    }
  };

  const handleEditProduct = (product: Product) => {
    setEditingProduct(product);
    setProductForm({
      name: product.name,
      description: product.description,
      priceMin: product.priceMin,
      priceMax: product.priceMax,
      category: product.category,
      tags: product.tags,
      siteId: product.siteId || '',
      images: product.images || [],
    });
    setIsOpen(true);
  };

  const handleDeleteProduct = (productId: string) => {
    if (window.confirm('Are you sure you want to delete this product?')) {
      setProducts(products.filter(p => p.id !== productId));
    }
  };

  const handleImageUpload = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (files && productForm.images.length < 3) {
      const newImages = Array.from(files).slice(0, 3 - productForm.images.length);
      const imageUrls = newImages.map(file => URL.createObjectURL(file));
      setProductForm({ ...productForm, images: [...productForm.images, ...imageUrls] });
    }
  };

  const removeImage = (index: number) => {
    setProductForm({
      ...productForm,
      images: productForm.images.filter((_, i) => i !== index),
    });
  };

  const toggleTag = (tag: string) => {
    if (productForm.tags.includes(tag)) {
      setProductForm({ ...productForm, tags: productForm.tags.filter(t => t !== tag) });
    } else {
      setProductForm({ ...productForm, tags: [...productForm.tags, tag] });
    }
  };

  const getSiteAddress = (siteId?: string) => {
    if (!siteId) return null;
    const site = sites.find(s => s.id === siteId);
    return site?.address;
  };

  const getCategoryLabel = (categoryValue: string) => {
    const cat = CATEGORIES.find(c => c.value === categoryValue);
    return cat ? `${cat.icon} ${cat.label}` : categoryValue;
  };

  return (
    <div className="min-h-screen px-6 py-12 pb-24 max-w-md mx-auto">
      {/* Back Button */}
      <motion.button
        onClick={() => navigate(-1)}
        className="mb-6 w-10 h-10 rounded-full bg-white/80 backdrop-blur-sm shadow-md flex items-center justify-center hover:bg-white transition-colors"
        initial={{ opacity: 0, x: -20 }}
        animate={{ opacity: 1, x: 0 }}
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
      >
        <ArrowLeft className="w-5 h-5 text-purple-600" />
      </motion.button>

      <div className="mb-8">
        <h1 className="text-3xl text-gray-800 mb-2">Products & Services</h1>
        <p className="text-purple-500">What do you offer?</p>
        <p className="text-gray-500 text-sm mt-2">
          {tier === 'basic' ? 'Basic: Up to 15 products (1 location)' : 'Plus: Up to 130 products (7 locations)'} 
          {' '}• {products.length}/{limits.maxProducts} used
        </p>
      </div>

      <div className="space-y-4 mb-6">
        {products.map((product) => (
          <RomanticCard key={product.id}>
            {/* Product Images - Top */}
            {product.images && product.images.length > 0 && (
              <div className={`grid gap-2 mb-4 ${
                product.images.length === 1 ? 'grid-cols-1' : 
                product.images.length === 2 ? 'grid-cols-2' : 
                'grid-cols-3'
              }`}>
                {product.images.map((image, index) => (
                  <div key={index} className="aspect-square rounded-[12px] overflow-hidden">
                    <img 
                      src={image} 
                      alt={`${product.name} ${index + 1}`} 
                      className="w-full h-full object-cover"
                    />
                  </div>
                ))}
              </div>
            )}

            <div className="flex items-start justify-between">
              <div className="flex-1">
                <h3 className="text-gray-800 mb-1">{product.name}</h3>
                {product.description && (
                  <p className="text-gray-500 text-xs mb-2">{product.description}</p>
                )}
                <p className="text-purple-600 text-sm font-semibold mb-1">${product.priceMin} - ${product.priceMax}</p>
                {product.category && (
                  <p className="text-purple-500 text-xs mb-2">{getCategoryLabel(product.category)}</p>
                )}
                <div className="flex flex-wrap gap-2 mb-2">
                  {product.tags.map((tag) => (
                    <span key={tag} className="px-2 py-1 bg-purple-50 text-purple-600 rounded-full text-xs">
                      {tag}
                    </span>
                  ))}
                </div>
                {product.siteId && (
                  <div className="flex items-center mt-2">
                    <MapPin className="w-4 h-4 text-purple-500 mr-1" />
                    <p className="text-gray-500 text-sm">{getSiteAddress(product.siteId)}</p>
                  </div>
                )}
              </div>
              <div className="flex gap-2 ml-3">
                <button className="p-2 rounded-full hover:bg-purple-50 transition-all" onClick={() => handleEditProduct(product)}>
                  <Edit className="w-4 h-4 text-purple-500" />
                </button>
                <button className="p-2 rounded-full hover:bg-red-50 transition-all" onClick={() => handleDeleteProduct(product.id)}>
                  <Trash2 className="w-4 h-4 text-red-400" />
                </button>
              </div>
            </div>
          </RomanticCard>
        ))}

        {/* Add Product Card - Opens Modal */}
        {canAddProduct(products.length) ? (
          <RomanticCard 
            className="border-2 border-dashed border-purple-200 cursor-pointer"
            onClick={() => setIsOpen(true)}
          >
            <div className="flex items-center justify-center gap-3 py-4 text-purple-500">
              <Plus className="w-6 h-6" />
              <span>Add Product or Service</span>
            </div>
          </RomanticCard>
        ) : (
          <div className="space-y-3">
            <RomanticCard className="border-2 border-dashed border-gray-200 bg-gray-50">
              <div className="flex items-center justify-center gap-3 py-4 text-gray-400">
                <Lock className="w-6 h-6" />
                <span>Product Limit Reached</span>
              </div>
            </RomanticCard>
            <motion.div
              className="p-4 rounded-[16px] bg-purple-50 border border-purple-100"
              initial={{ opacity: 0, y: -10 }}
              animate={{ opacity: 1, y: 0 }}
            >
              <p className="text-sm text-purple-700 text-center mb-1">
                You've reached your limit of <span className="font-medium">{limits.maxProducts} products</span>
              </p>
              <p className="text-xs text-purple-600 text-center mb-3">
                Upgrade to {tier === 'basic' ? 'Plus' : 'Premium'} to add more products
              </p>
              <button
                onClick={() => navigate('/business/subscription')}
                className="w-full py-3 px-4 bg-gradient-to-r from-purple-400 to-indigo-400 text-white rounded-[12px] text-sm font-medium hover:shadow-md transition-all"
              >
                View Subscription Plans
              </button>
            </motion.div>
          </div>
        )}
      </div>

      <div className="fixed bottom-6 left-6 right-6 max-w-md mx-auto">
        <RomanticButton fullWidth onClick={() => {
          // Mark onboarding as completed in localStorage
          const existingUsersJson = localStorage.getItem('cherish_users');
          if (existingUsersJson) {
            const existingUsers = JSON.parse(existingUsersJson);
            const userIndex = existingUsers.findIndex((u: any) => u.userType === 'business');
            
            if (userIndex !== -1) {
              existingUsers[userIndex].onboardingCompleted = true;
              localStorage.setItem('cherish_users', JSON.stringify(existingUsers));
            }
          }
          
          navigate('/business/dashboard');
        }}>
          Complete Registration
        </RomanticButton>
      </div>

      {/* Add Product Modal */}
      <AnimatePresence>
        {isOpen && (
          <motion.div
            className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 px-6"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={() => {
              setIsOpen(false);
              setEditingProduct(null);
              setProductForm({ name: '', description: '', priceMin: 50, priceMax: 100, category: '', tags: [], siteId: '', images: [] });
            }}
          >
            <motion.div
              className="bg-white rounded-[20px] shadow-2xl max-w-md w-full max-h-[85vh] overflow-hidden"
              initial={{ scale: 0.9, y: 20 }}
              animate={{ scale: 1, y: 0 }}
              exit={{ scale: 0.9, y: 20 }}
              onClick={(e) => e.stopPropagation()}
            >
              {/* Header */}
              <div className="bg-gradient-to-br from-purple-400 to-indigo-400 px-6 py-6 rounded-t-[20px]">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <div className="w-10 h-10 rounded-full bg-white/20 backdrop-blur-sm flex items-center justify-center">
                      <Package className="w-5 h-5 text-white" />
                    </div>
                    <div>
                      <h2 className="text-xl text-white mb-1">
                        {editingProduct ? 'Edit Product/Service' : 'Add Product/Service'}
                      </h2>
                      <p className="text-white/80 text-sm">
                        {editingProduct ? 'Update your offering' : 'Tell us what you offer'}
                      </p>
                    </div>
                  </div>
                  <button
                    onClick={() => {
                      setIsOpen(false);
                      setEditingProduct(null);
                      setProductForm({ name: '', description: '', priceMin: 50, priceMax: 100, category: '', tags: [], siteId: '', images: [] });
                    }}
                    className="w-8 h-8 rounded-full bg-white/20 backdrop-blur-sm flex items-center justify-center hover:bg-white/30 transition-colors"
                  >
                    <span className="text-white text-xl">×</span>
                  </button>
                </div>
              </div>

              {/* Form Content */}
              <div className="p-6 space-y-5 overflow-y-auto max-h-[calc(85vh-120px)]">
                <RomanticInput
                  label="Product/Service Name *"
                  placeholder="e.g., Custom Bouquet"
                  value={productForm.name}
                  onChange={(e) => setProductForm({ ...productForm, name: e.target.value })}
                  required
                />

                {/* Location Name Selection */}
                <div>
                  <label className="block text-purple-700 mb-2 text-sm">
                    Location Name *
                  </label>
                  <select
                    className="w-full px-6 py-4 bg-white/60 backdrop-blur-sm border-2 border-purple-100 rounded-[16px] 
                      focus:outline-none focus:border-purple-300 focus:bg-white/80 transition-all text-gray-700 appearance-none cursor-pointer"
                    style={{
                      backgroundImage: `url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%239333ea' d='M6 9L1 4h10z'/%3E%3C/svg%3E")`,
                      backgroundRepeat: 'no-repeat',
                      backgroundPosition: 'right 1.5rem center',
                      backgroundSize: '12px'
                    }}
                    value={productForm.siteId}
                    onChange={(e) => setProductForm({ ...productForm, siteId: e.target.value })}
                    required
                  >
                    <option value="">Select a location</option>
                    {sites.map(site => (
                      <option key={site.id} value={site.id}>{site.locationName}</option>
                    ))}
                  </select>
                </div>

                {/* Category Selection */}
                <div>
                  <label className="block text-purple-700 mb-2 text-sm">
                    Product/Service Category *
                  </label>
                  <select
                    className="w-full px-6 py-4 bg-white/60 backdrop-blur-sm border-2 border-purple-100 rounded-[16px] 
                      focus:outline-none focus:border-purple-300 focus:bg-white/80 transition-all text-gray-700 appearance-none cursor-pointer"
                    style={{
                      backgroundImage: `url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%239333ea' d='M6 9L1 4h10z'/%3E%3C/svg%3E")`,
                      backgroundRepeat: 'no-repeat',
                      backgroundPosition: 'right 1.5rem center',
                      backgroundSize: '12px'
                    }}
                    value={productForm.category}
                    onChange={(e) => setProductForm({ ...productForm, category: e.target.value })}
                    required
                  >
                    <option value="">Select a category</option>
                    {CATEGORIES.map((cat) => (
                      <option key={cat.value} value={cat.value}>
                        {cat.icon} {cat.label}
                      </option>
                    ))}
                  </select>
                </div>

                {/* Product Description */}
                <div>
                  <label className="block text-purple-700 mb-2 text-sm">Product Description *</label>
                  <textarea
                    className="w-full px-6 py-4 bg-white/60 backdrop-blur-sm border-2 border-purple-100 rounded-[16px] 
                      focus:outline-none focus:border-purple-300 focus:bg-white/80 transition-all placeholder-purple-300 
                      text-gray-700 min-h-[80px]"
                    placeholder="Brief description of what you offer..."
                    value={productForm.description}
                    onChange={(e) => setProductForm({ ...productForm, description: e.target.value })}
                    required
                  />
                </div>

                {/* Price Range - Dual Sliders */}
                <div className="space-y-4">
                  <div>
                    <label className="block text-purple-700 mb-3 text-sm">
                      Price Range * 
                      <span className="text-purple-500 ml-2 font-semibold">${productForm.priceMin} - ${productForm.priceMax}</span>
                    </label>
                    
                    {/* Minimum Price Slider */}
                    <div className="mb-4">
                      <label className="block text-gray-600 mb-2 text-xs">Minimum Price</label>
                      <input
                        type="range"
                        min="0"
                        max="1000"
                        step="5"
                        value={productForm.priceMin}
                        onChange={(e) => {
                          const newMin = parseInt(e.target.value);
                          if (newMin <= productForm.priceMax) {
                            setProductForm({ ...productForm, priceMin: newMin });
                          }
                        }}
                        className="w-full h-2 bg-purple-100 rounded-full appearance-none cursor-pointer
                          [&::-webkit-slider-thumb]:appearance-none [&::-webkit-slider-thumb]:w-5 [&::-webkit-slider-thumb]:h-5 
                          [&::-webkit-slider-thumb]:rounded-full [&::-webkit-slider-thumb]:bg-gradient-to-r 
                          [&::-webkit-slider-thumb]:from-purple-400 [&::-webkit-slider-thumb]:to-indigo-400 
                          [&::-webkit-slider-thumb]:shadow-lg [&::-webkit-slider-thumb]:cursor-pointer
                          [&::-webkit-slider-thumb]:transition-transform [&::-webkit-slider-thumb]:hover:scale-110
                          [&::-moz-range-thumb]:w-5 [&::-moz-range-thumb]:h-5 [&::-moz-range-thumb]:rounded-full \n                          [&::-moz-range-thumb]:bg-gradient-to-r [&::-moz-range-thumb]:from-purple-400 \n                          [&::-moz-range-thumb]:to-indigo-400 [&::-moz-range-thumb]:border-0 \n                          [&::-moz-range-thumb]:shadow-lg [&::-moz-range-thumb]:cursor-pointer"
                      />
                    </div>

                    {/* Maximum Price Slider */}
                    <div>
                      <label className="block text-gray-600 mb-2 text-xs">Maximum Price</label>
                      <input
                        type="range"
                        min="0"
                        max="1000"
                        step="5"
                        value={productForm.priceMax}
                        onChange={(e) => {
                          const newMax = parseInt(e.target.value);
                          if (newMax >= productForm.priceMin) {
                            setProductForm({ ...productForm, priceMax: newMax });
                          }
                        }}
                        className="w-full h-2 bg-purple-100 rounded-full appearance-none cursor-pointer
                          [&::-webkit-slider-thumb]:appearance-none [&::-webkit-slider-thumb]:w-5 [&::-webkit-slider-thumb]:h-5 
                          [&::-webkit-slider-thumb]:rounded-full [&::-webkit-slider-thumb]:bg-gradient-to-r 
                          [&::-webkit-slider-thumb]:from-rose-400 [&::-webkit-slider-thumb]:to-pink-400 
                          [&::-webkit-slider-thumb]:shadow-lg [&::-webkit-slider-thumb]:cursor-pointer
                          [&::-webkit-slider-thumb]:transition-transform [&::-webkit-slider-thumb]:hover:scale-110
                          [&::-moz-range-thumb]:w-5 [&::-moz-range-thumb]:h-5 [&::-moz-range-thumb]:rounded-full \n                          [&::-moz-range-thumb]:bg-gradient-to-r [&::-moz-range-thumb]:from-rose-400 \n                          [&::-moz-range-thumb]:to-pink-400 [&::-moz-range-thumb]:border-0 \n                          [&::-moz-range-thumb]:shadow-lg [&::-moz-range-thumb]:cursor-pointer"
                      />
                    </div>

                    <div className="flex justify-between mt-2 text-xs text-gray-500">
                      <span>$0</span>
                      <span>$500</span>
                      <span>$1000</span>
                    </div>
                  </div>
                </div>

                {/* Occasion Tags Selection */}
                <div>
                  <label className="block text-purple-700 mb-3 text-sm">
                    Occasions (Optional)
                  </label>
                  <div className="flex flex-wrap gap-2">
                    {TAGS.map((tag) => (
                      <button
                        key={tag}
                        type="button"
                        onClick={() => toggleTag(tag)}
                        className={`px-3 py-1.5 rounded-full text-xs transition-all ${
                          productForm.tags.includes(tag)
                            ? 'bg-gradient-to-r from-purple-400 to-indigo-400 text-white shadow-md'
                            : 'bg-purple-50 text-purple-600 hover:bg-purple-100'
                        }`}
                      >
                        {tag}
                      </button>
                    ))}
                  </div>
                </div>

                {/* Image Upload Section */}
                <div>
                  <label className="block text-purple-700 mb-3 text-sm">
                    Product Images 
                    <span className="text-gray-500 text-xs ml-2">({productForm.images.length}/3)</span>
                  </label>
                  
                  {productForm.images.length < 3 && (
                    <div>
                      <input
                        type="file"
                        accept="image/*"
                        multiple
                        className="hidden"
                        id="product-images"
                        onChange={handleImageUpload}
                      />
                      <label
                        htmlFor="product-images"
                        className="flex flex-col items-center justify-center px-6 py-6 border-2 border-dashed 
                          border-purple-200 rounded-[16px] bg-purple-50/30 hover:bg-purple-50/50 
                          cursor-pointer transition-all group"
                      >
                        <div className="w-12 h-12 rounded-full bg-gradient-to-br from-purple-400 to-indigo-400 
                          flex items-center justify-center mb-2 group-hover:scale-110 transition-transform">
                          <Upload className="w-6 h-6 text-white" />
                        </div>
                        <p className="text-purple-600 text-sm mb-1">Upload Product Images</p>
                        <p className="text-gray-400 text-xs">Up to 3 images, PNG or JPG</p>
                      </label>
                    </div>
                  )}

                  {/* Image Preview Grid */}
                  {productForm.images.length > 0 && (
                    <div className="grid grid-cols-3 gap-3 mt-3">
                      {productForm.images.map((image, index) => (
                        <motion.div
                          key={index}
                          initial={{ opacity: 0, scale: 0.8 }}
                          animate={{ opacity: 1, scale: 1 }}
                          className="relative aspect-square rounded-[12px] overflow-hidden group"
                        >
                          <img
                            src={image}
                            alt={`Product ${index + 1}`}
                            className="w-full h-full object-cover"
                          />
                          <button
                            type="button"
                            onClick={() => removeImage(index)}
                            className="absolute top-1 right-1 w-6 h-6 bg-red-500 text-white rounded-full 
                              flex items-center justify-center opacity-0 group-hover:opacity-100 
                              transition-opacity shadow-lg hover:bg-red-600"
                          >
                            <X className="w-4 h-4" />
                          </button>
                        </motion.div>
                      ))}
                    </div>
                  )}
                </div>

                <RomanticButton
                  fullWidth
                  type="button"
                  onClick={handleAddProduct}
                  disabled={!productForm.name.trim() || !productForm.description.trim() || !productForm.category || !productForm.siteId}
                >
                  {editingProduct ? 'Update Product' : 'Add Product'}
                </RomanticButton>
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}