import { InputHTMLAttributes, SelectHTMLAttributes } from 'react';

interface BaseProps {
  label?: string;
  error?: string;
  className?: string;
}

interface TextInputProps extends BaseProps, InputHTMLAttributes<HTMLInputElement> {
  mode?: 'input';
  options?: never;
}

interface SelectInputProps extends BaseProps, Omit<SelectHTMLAttributes<HTMLSelectElement>, 'className'> {
  mode: 'select';
  options: Array<{ value: string; label: string }>;
}

type RomanticInputProps = TextInputProps | SelectInputProps;

export default function RomanticInput({ label, error, className = '', mode = 'input', ...props }: RomanticInputProps) {
  const sharedClassName = `w-full px-6 py-4 bg-white/60 backdrop-blur-sm border-2 border-rose-100 rounded-[16px] 
    focus:outline-none focus:bg-white/80 transition-all placeholder-rose-300 
    text-gray-700 ${error ? 'border-red-300' : ''} ${className}`;

  const sharedStyle = {
    boxShadow: '0px 4px 12px rgba(246, 166, 193, 0.2)',
  };

  const handleFocus = (e: React.FocusEvent<HTMLInputElement | HTMLSelectElement>) => {
    e.currentTarget.style.borderColor = '#E91E63';
    e.currentTarget.style.boxShadow = '0px 8px 24px rgba(233, 30, 99, 0.4), 0px 0px 20px rgba(233, 30, 99, 0.2)';
  };

  const handleBlur = (e: React.FocusEvent<HTMLInputElement | HTMLSelectElement>) => {
    if (!error) {
      e.currentTarget.style.borderColor = '#fecdd3';
      e.currentTarget.style.boxShadow = '0px 4px 12px rgba(246, 166, 193, 0.2)';
    }
  };

  return (
    <div className="w-full">
      {label && <label className="block text-rose-700 mb-2 text-sm">{label}</label>}
      
      {mode === 'select' ? (
        <select
          className={sharedClassName}
          style={sharedStyle}
          onFocus={handleFocus}
          onBlur={handleBlur}
          {...(props as SelectInputProps)}
        >
          {(props as SelectInputProps).options?.map((option) => (
            <option key={option.value} value={option.value}>
              {option.label}
            </option>
          ))}
        </select>
      ) : (
        <input
          className={sharedClassName}
          style={sharedStyle}
          onFocus={handleFocus}
          onBlur={handleBlur}
          {...(props as TextInputProps)}
        />
      )}
      
      {error && <p className="text-red-400 text-sm mt-1">{error}</p>}
    </div>
  );
}
