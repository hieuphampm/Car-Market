import React from "react";
export const SignUpForm = () => {
  return (
    <form className="space-y-6">
      <div className="grid grid-cols-2 gap-4">
        <div>
          <label
            htmlFor="firstName"
            className="block text-sm font-medium text-gray-700 mb-1"
          >
            First Name
          </label>
          <input
            type="text"
            id="firstName"
            className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-[#1A3D7A]"
            placeholder="John"
          />
        </div>
        <div>
          <label
            htmlFor="lastName"
            className="block text-sm font-medium text-gray-700 mb-1"
          >
            Last Name
          </label>
          <input
            type="text"
            id="lastName"
            className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-[#1A3D7A]"
            placeholder="Doe"
          />
        </div>
      </div>
      <div>
        <label
          htmlFor="email"
          className="block text-sm font-medium text-gray-700 mb-1"
        >
          Email
        </label>
        <input
          type="email"
          id="email"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-[#1A3D7A]"
          placeholder="john@example.com"
        />
      </div>
      <div>
        <label
          htmlFor="password"
          className="block text-sm font-medium text-gray-700 mb-1"
        >
          Password
        </label>
        <input
          type="password"
          id="password"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-[#1A3D7A]"
          placeholder="Create a strong password"
        />
      </div>
      <div>
        <label
          htmlFor="confirmPassword"
          className="block text-sm font-medium text-gray-700 mb-1"
        >
          Confirm Password
        </label>
        <input
          type="password"
          id="confirmPassword"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-[#1A3D7A]"
          placeholder="Confirm your password"
        />
      </div>
      <div className="flex items-center">
        <input
          type="checkbox"
          id="terms"
          className="h-4 w-4 text-[#1A3D7A] focus:ring-[#1A3D7A] border-gray-300 rounded"
        />
        <label htmlFor="terms" className="ml-2 block text-sm text-gray-700">
          I agree to the{" "}
          <a href="#" className="text-[#1A3D7A] hover:underline">
            Terms of Service
          </a>{" "}
          and{" "}
          <a href="#" className="text-[#1A3D7A] hover:underline">
            Privacy Policy
          </a>
        </label>
      </div>
      <button
        type="submit"
        className="w-full bg-[#1A3D7A] text-white py-2 px-4 rounded-md hover:bg-[#15305F] transition-colors duration-200"
      >
        Create Account
      </button>
      <p className="text-center text-sm text-gray-600">
        Already have an account?{" "}
        <a href="#" className="text-[#1A3D7A] hover:underline">
          Sign in
        </a>
      </p>
    </form>
  );
};
