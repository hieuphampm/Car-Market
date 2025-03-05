import React, { useState } from "react";
import { Link } from "react-router-dom";
import { Menu, X, Search, ShoppingCart, User } from "lucide-react";

const Navigation = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  return (
    <header className="w-full bg-white border-b border-gray-100 sticky top-0 z-50">
      <div className="container mx-auto px-4 py-4 flex items-center justify-between">
        <Link to="/" className="flex items-center">
          <img
            src="https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/aircarft%2Flogo.png?alt=media&token=d90aeea8-428d-4f37-908f-a4a77640e426"
            alt="Aircraft Market"
            className="h-15"
          />
        </Link>
        {/* Desktop Navigation */}
        <nav className="hidden md:flex items-center space-x-8">
          <Link
            to="/"
            className="font-medium text-gray-800 hover:text-blue-600 transition-colors"
          >
            Home
          </Link>
          <Link
            to="/aircraft"
            className="font-medium text-gray-800 hover:text-blue-600 transition-colors"
          >
            Aircraft
          </Link>
          <Link
            to="/about"
            className="font-medium text-gray-800 hover:text-blue-600 transition-colors"
          >
            About Us
          </Link>
          <Link
            to="/blog"
            className="font-medium text-gray-800 hover:text-blue-600 transition-colors"
          >
            Blog
          </Link>
          <Link
            to="/contact"
            className="font-medium text-gray-800 hover:text-blue-600 transition-colors"
          >
            Contact
          </Link>
        </nav>
        {/* Desktop Action Buttons */}
        <div className="hidden md:flex items-center space-x-4">
          <button className="p-2 text-gray-600 hover:text-blue-600 transition-colors">
            <Search size={20} />
          </button>
          <Link
            to="/cart"
            className="p-2 text-gray-600 hover:text-blue-600 transition-colors"
          >
            <ShoppingCart size={20} />
          </Link>
          <Link
            to="/login"
            className="p-2 text-gray-600 hover:text-blue-600 transition-colors"
          >
            <User size={20} />
          </Link>
        </div>
        {/* Mobile Menu Button */}
        <button
          className="md:hidden p-2 text-gray-600"
          onClick={() => setIsMenuOpen(!isMenuOpen)}
        >
          {isMenuOpen ? <X size={24} /> : <Menu size={24} />}
        </button>
      </div>
      {/* Mobile Menu */}
      {isMenuOpen && (
        <div className="md:hidden bg-white py-4 px-4 border-t border-gray-100">
          <nav className="flex flex-col space-y-4">
            <Link
              to="/"
              className="font-medium text-gray-800 hover:text-blue-600 transition-colors py-2"
            >
              Home
            </Link>
            <Link
              to="/aircraft"
              className="font-medium text-gray-800 hover:text-blue-600 transition-colors py-2"
            >
              Aircraft
            </Link>
            <Link
              to="/about"
              className="font-medium text-gray-800 hover:text-blue-600 transition-colors py-2"
            >
              About Us
            </Link>
            <Link
              to="/blog"
              className="font-medium text-gray-800 hover:text-blue-600 transition-colors py-2"
            >
              Blog
            </Link>
            <Link
              to="/contact"
              className="font-medium text-gray-800 hover:text-blue-600 transition-colors py-2"
            >
              Contact
            </Link>
            <div className="flex space-x-4 py-2">
              <button className="p-2 text-gray-600 hover:text-blue-600 transition-colors">
                <Search size={20} />
              </button>
              <Link
                to="/cart"
                className="p-2 text-gray-600 hover:text-blue-600 transition-colors"
              >
                <ShoppingCart size={20} />
              </Link>
              <Link
                to="/login"
                className="p-2 text-gray-600 hover:text-blue-600 transition-colors"
              >
                <User size={20} />
              </Link>
            </div>
          </nav>
        </div>
      )}
    </header>
  );
};
export default Navigation;
