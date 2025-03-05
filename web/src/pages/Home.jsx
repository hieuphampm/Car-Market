import React from "react";
import { Link } from "react-router-dom";
import { ChevronRight, ArrowRight } from "lucide-react";
import HeroBanner from "../components/HeroBanner";
import AircraftSlider from "../components/AircraftSlider";
import CategoryCard from "../components/CategoryCard";
import TestimonialSection from "../components/TestimonialSection";

const Home = () => {
  const categories = [
    {
      id: 1,
      title: "Commercial Aircraft",
      description: "Airliners and cargo planes for commercial operations",
      image:
        "https://images.unsplash.com/photo-1569629743817-70d8db6c323b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      link: "/aircraft?category=commercial",
    },
    {
      id: 2,
      title: "Private Jets",
      description: "Luxury private jets for business and personal use",
      image:
        "https://images.unsplash.com/photo-1540962351504-03099e0a754b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      link: "/aircraft?category=private",
    },
    {
      id: 3,
      title: "Cargo Aircraft",
      description: "Versatile helicopters for various applications",
      image:
        "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/aircarft%2Fatr-72%2Fatr72.jpg?alt=media&token=6ea2e00a-59ed-4469-a5b6-c02b2ac61bbc",
      link: "/aircraft?category=helicopter",
    },
  ];
  return (
    <div className="w-full">
      {/* Hero Banner */}
      <HeroBanner />
      {/* Latest Aircraft Section */}
      <section className="py-16 bg-gray-50">
        <div className="container mx-auto px-4">
          <div className="flex justify-between items-center mb-8">
            <h2 className="text-3xl font-bold">Latest Aircraft</h2>
            <Link
              to="/aircraft"
              className="flex items-center text-blue-600 hover:text-blue-800 transition-colors"
            >
              View all <ChevronRight size={20} />
            </Link>
          </div>
          <AircraftSlider />
        </div>
      </section>
      {/* Categories Section */}
      <section className="py-16">
        <div className="container mx-auto px-4">
          <h2 className="text-3xl font-bold text-center mb-12">
            Featured Categories
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {categories.map((category) => (
              <CategoryCard key={category.id} category={category} />
            ))}
          </div>
        </div>
      </section>
      {/* Brand Information Section */}
      <section className="py-16 bg-blue-900 text-white">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
            <div>
              <h2 className="text-3xl font-bold mb-6">
                The Premier Aircraft Marketplace
              </h2>
              <p className="mb-6">
                Aircraft Market has been connecting buyers and sellers of
                aircraft since 1995. Our mission is to make aircraft trading
                accessible, transparent, and secure for everyone.
              </p>
              <p className="mb-8">
                With thousands of listings across all aircraft categories, from
                commercial airliners to private jets and helicopters, we're the
                trusted platform for aviation professionals and enthusiasts
                alike.
              </p>
              <Link
                to="/about"
                className="inline-flex items-center px-6 py-3 bg-white text-blue-900 font-medium rounded-lg hover:bg-gray-100 transition-colors shadow-md"
              >
                Learn more about us <ArrowRight size={18} className="ml-2" />
              </Link>
            </div>
            <div className="relative">
              <img
                src="https://images.unsplash.com/photo-1559628233-100c798642d4?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80"
                alt="Aircraft handshake deal"
                className="rounded-lg shadow-xl"
              />
              <div className="absolute -bottom-8 -left-8 bg-blue-800 p-6 rounded-lg shadow-lg hidden md:block">
                <p className="text-2xl font-bold">25+</p>
                <p className="text-blue-200">Years of Experience</p>
              </div>
            </div>
          </div>
        </div>
      </section>
      {/* Testimonials Section */}
      <TestimonialSection />
      {/* CTA Section */}
      <section className="py-16 bg-gray-900 text-white">
        <div className="container mx-auto px-4 text-center">
          <h2 className="text-3xl font-bold mb-4">
            Ready to Find Your Perfect Aircraft?
          </h2>
          <p className="text-gray-300 max-w-2xl mx-auto mb-8">
            Join thousands of satisfied customers who have found their ideal
            aircraft through our marketplace.
          </p>
          <div className="flex justify-center space-x-4">
            <Link
              to="/aircraft"
              className="px-8 py-4 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 transition-colors shadow-lg"
            >
              Explore Aircraft
            </Link>
            <Link
              to="/contact"
              className="px-8 py-4 bg-transparent border border-white text-white font-medium rounded-lg hover:bg-white hover:text-gray-900 transition-colors"
            >
              Contact Us
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
};
export default Home;
