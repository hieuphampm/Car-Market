import React from "react";
import { Shield, Globe, Award } from "lucide-react";
export const CompanyInfo = () => {
  return (
    <section className="py-16 bg-[#1A3D7A] text-white">
      <div className="container mx-auto px-4">
        <div className="grid md:grid-cols-3 gap-8 text-center">
          <div className="flex flex-col items-center">
            <Shield className="w-12 h-12 text-[#F5C518] mb-4" />
            <h3 className="text-xl font-semibold mb-2">Trusted Worldwide</h3>
            <p className="text-[#D1D5DB]">
              Over 20 years of excellence in aircraft trading
            </p>
          </div>
          <div className="flex flex-col items-center">
            <Globe className="w-12 h-12 text-[#F5C518] mb-4" />
            <h3 className="text-xl font-semibold mb-2">Global Network</h3>
            <p className="text-[#D1D5DB]">
              Connected with leading manufacturers and operators
            </p>
          </div>
          <div className="flex flex-col items-center">
            <Award className="w-12 h-12 text-[#F5C518] mb-4" />
            <h3 className="text-xl font-semibold mb-2">Expert Service</h3>
            <p className="text-[#D1D5DB]">
              Professional guidance through every transaction
            </p>
          </div>
        </div>
      </div>
    </section>
  );
};
