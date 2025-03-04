import React from "react";
export const HeroBanner = () => {
  return (
    <section className="relative h-[600px] w-full bg-[#1A3D7A] text-white">
      <div className="absolute inset-0 bg-[url('https://images.unsplash.com/photo-1474302770737-173ee21bab63?ixlib=rb-4.0.3')] bg-cover bg-center bg-no-repeat opacity-40"></div>
      <div className="relative container mx-auto px-4 h-full flex items-center">
        <div className="max-w-2xl">
          <h1 className="text-5xl font-bold mb-6">
            Your Gateway to Premium Aircraft
          </h1>
          <p className="text-xl mb-8">
            Discover an exclusive collection of commercial and private aircraft,
            where luxury meets performance.
          </p>
          <button
            className="bg-[#F5C518] text-[#1A3D7A] px-8 py-3 rounded-md font-semibold 
            hover:bg-[#D1D5DB] transition-colors duration-300"
          >
            Explore Now
          </button>
        </div>
      </div>
    </section>
  );
};
