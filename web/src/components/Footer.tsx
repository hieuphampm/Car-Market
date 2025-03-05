import React from "react";
import { Link } from "react-router-dom";
import {
  Mail,
  Phone,
  MapPin,
  Facebook,
  Twitter,
  Instagram,
  Linkedin,
} from "lucide-react";
const Footer = () => {
  return (
    <footer className="bg-gray-900 text-white">
      <div className="container mx-auto px-4 py-12">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          <div>
            <img
              src="https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/aircarft%2Flogo.png?alt=media&token=d90aeea8-428d-4f37-908f-a4a77640e426"
              alt="Aircraft Market"
              className="h-30 mb-4 invert"
            />
            <p className="text-gray-400 mb-4">
              Your premier destination for buying and selling aircraft
              worldwide.
            </p>
            <div className="flex space-x-4">
              <a
                href="#"
                className="text-gray-400 hover:text-white transition-colors"
              >
                <Facebook size={20} />
              </a>
              <a
                href="#"
                className="text-gray-400 hover:text-white transition-colors"
              >
                <Twitter size={20} />
              </a>
              <a
                href="#"
                className="text-gray-400 hover:text-white transition-colors"
              >
                <Instagram size={20} />
              </a>
              <a
                href="#"
                className="text-gray-400 hover:text-white transition-colors"
              >
                <Linkedin size={20} />
              </a>
            </div>
          </div>
          <div>
            <h3 className="font-bold text-lg mb-4">Quick Links</h3>
            <ul className="space-y-2">
              <li>
                <Link
                  to="/"
                  className="text-gray-400 hover:text-white transition-colors"
                >
                  Home
                </Link>
              </li>
              <li>
                <Link
                  to="/aircraft"
                  className="text-gray-400 hover:text-white transition-colors"
                >
                  Aircraft
                </Link>
              </li>
              <li>
                <Link
                  to="/about"
                  className="text-gray-400 hover:text-white transition-colors"
                >
                  About Us
                </Link>
              </li>
              <li>
                <Link
                  to="/blog"
                  className="text-gray-400 hover:text-white transition-colors"
                >
                  Blog
                </Link>
              </li>
              <li>
                <Link
                  to="/contact"
                  className="text-gray-400 hover:text-white transition-colors"
                >
                  Contact
                </Link>
              </li>
            </ul>
          </div>
          <div>
            <h3 className="font-bold text-lg mb-4">Aircraft Categories</h3>
            <ul className="space-y-2">
              <li>
                <Link
                  to="/aircraft?category=commercial"
                  className="text-gray-400 hover:text-white transition-colors"
                >
                  Commercial Aircraft
                </Link>
              </li>
              <li>
                <Link
                  to="/aircraft?category=private"
                  className="text-gray-400 hover:text-white transition-colors"
                >
                  Private Jets
                </Link>
              </li>
              <li>
                <Link
                  to="/aircraft?category=helicopter"
                  className="text-gray-400 hover:text-white transition-colors"
                >
                  Helicopters
                </Link>
              </li>
              <li>
                <Link
                  to="/aircraft?category=vintage"
                  className="text-gray-400 hover:text-white transition-colors"
                >
                  Vintage Aircraft
                </Link>
              </li>
            </ul>
          </div>
          <div>
            <h3 className="font-bold text-lg mb-4">Contact Us</h3>
            <ul className="space-y-2">
              <li className="flex items-center text-gray-400">
                <MapPin size={18} className="mr-2" />
                <span>123 Aviation Way, Skyline City</span>
              </li>
              <li className="flex items-center text-gray-400">
                <Phone size={18} className="mr-2" />
                <span>+1 (555) 123-4567</span>
              </li>
              <li className="flex items-center text-gray-400">
                <Mail size={18} className="mr-2" />
                <span>info@aircraftmarket.com</span>
              </li>
            </ul>
          </div>
        </div>
        <div className="border-t border-gray-800 mt-8 pt-8 text-center text-gray-500">
          <p>
            &copy; {new Date().getFullYear()} Aircraft Market. All rights
            reserved.
          </p>
        </div>
      </div>
    </footer>
  );
};
export default Footer;
