import React from "react";
import { Menu, Search, User } from "lucide-react";
import { Link } from "react-router-dom";

export const Header = () => {
  return (
    <header className="w-full bg-[#1A3D7A] text-white py-4">
      <div className="container mx-auto flex items-center justify-between px-4">
        <div className="flex items-center space-x-8">
          <h1 className="text-2xl font-bold">AirMarket</h1>
          <nav className="hidden md:flex space-x-6">
            <a href="#" className="hover:text-[#F5C518]">
              Home
            </a>
            <a href="#" className="hover:text-[#F5C518]">
              Aircraft
            </a>
            <a href="#" className="hover:text-[#F5C518]">
              Categories
            </a>
            <a href="#" className="hover:text-[#F5C518]">
              About
            </a>
            <a href="#" className="hover:text-[#F5C518]">
              Contact
            </a>
          </nav>
        </div>
        <div className="flex items-center space-x-4">
          <Search className="w-5 h-5 cursor-pointer hover:text-[#F5C518]" />
          <Link to="/login">
            <User className="w-5 h-5 cursor-pointer hover:text-[#F5C518]" />
            </Link>
          <Menu className="md:hidden w-5 h-5 cursor-pointer" />
        </div>
      </div>
    </header>
  );
};
