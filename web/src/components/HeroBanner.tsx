import React from "react";
import { Link } from "react-router-dom";
const HeroBanner = () => {
  return (
    <section className="relative h-[600px] w-full overflow-hidden">
      {/* Background Image */}
      <div className="absolute inset-0">
        <img
          src="https://images.unsplash.com/photo-1559628233-eb1b1a45564b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1920&q=80"
          alt="Aircraft in flight"
          className="w-full h-full object-cover"
        />
        <div className="absolute inset-0 bg-gradient-to-r from-black/70 to-black/30" />
      </div>
      {/* Content */}
      <div className="container mx-auto px-4 h-full relative">
        <div className="flex flex-col justify-center h-full max-w-2xl">
          <h1 className="text-4xl md:text-5xl lg:text-6xl font-bold text-white mb-6 leading-tight">
            Your Journey to the Perfect Aircraft Starts Here
          </h1>
          <p className="text-xl text-gray-200 mb-8">
            Browse our extensive collection of commercial and private aircraft,
            helicopters, and more.
          </p>
          <div className="flex flex-col sm:flex-row space-y-4 sm:space-y-0 sm:space-x-4">
            <Link
              to="/aircraft"
              className="px-8 py-4 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 transition-colors shadow-lg text-center"
            >
              Explore Now
            </Link>
            <Link
              to="/contact"
              className="px-8 py-4 bg-transparent border border-white text-white font-medium rounded-lg hover:bg-white hover:text-gray-900 transition-colors text-center"
            >
              Request Consultation
            </Link>
          </div>
        </div>
      </div>
      {/* Animated scroll indicator */}
      <div className="absolute bottom-8 left-1/2 transform -translate-x-1/2">
        <div className="w-8 h-12 border-2 border-white rounded-full flex justify-center">
          <div className="w-1 h-3 bg-white rounded-full animate-bounce mt-2"></div>
        </div>
      </div>
    </section>
  );
};
export default HeroBanner;
