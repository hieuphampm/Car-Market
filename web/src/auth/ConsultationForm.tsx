import React from "react";
export const ConsultationForm = () => {
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
          htmlFor="phone"
          className="block text-sm font-medium text-gray-700 mb-1"
        >
          Phone Number
        </label>
        <input
          type="tel"
          id="phone"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-[#1A3D7A]"
          placeholder="+1 (555) 000-0000"
        />
      </div>
      <div>
        <label
          htmlFor="interest"
          className="block text-sm font-medium text-gray-700 mb-1"
        >
          Aircraft Interest
        </label>
        <select
          id="interest"
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-[#1A3D7A]"
        >
          <option value="">Select aircraft type</option>
          <option value="commercial">Commercial Aircraft</option>
          <option value="private">Private Jets</option>
          <option value="helicopter">Helicopters</option>
        </select>
      </div>
      <div>
        <label
          htmlFor="message"
          className="block text-sm font-medium text-gray-700 mb-1"
        >
          Message
        </label>
        <textarea
          id="message"
          rows={4}
          className="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-[#1A3D7A]"
          placeholder="Tell us about your requirements and preferences"
        ></textarea>
      </div>
      <button
        type="submit"
        className="w-full bg-[#F5C518] text-[#1A3D7A] py-2 px-4 rounded-md hover:bg-[#D1D5DB] transition-colors duration-200 font-semibold"
      >
        Schedule Consultation
      </button>
    </form>
  );
};
