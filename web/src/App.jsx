import { Routes, Route } from "react-router-dom";
import { useState } from "react";
import Navbar from "./components/Navbar";
import Home from "./components/Home";
import Listings from "./components/Listings";
import Contact from "./components/Contact";
import Footer from "./components/Footer";
import Login from "./components/Login";
import Logout from "./components/Logout";
import Signin from "./components/Signin";
import "./App.css";

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  const handleLogin = () => setIsAuthenticated(true);
  const handleLogout = () => setIsAuthenticated(false);

  return (
    <div className="flex flex-col min-h-screen bg-gray-100 text-gray-900 font-sans">
      <Navbar isAuthenticated={isAuthenticated} onLogout={handleLogout} />
      <main className="flex-grow p-6 container mx-auto">
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/listings" element={<Listings />} />
          <Route path="/contact" element={<Contact />} />
          <Route path="/signin" element={<Signin />} />
          <Route path="/login" element={<Login onLogin={handleLogin} />} />
          <Route path="/logout" element={<Logout onLogout={handleLogout} />} />
        </Routes>
      </main>
      <Footer />
    </div>
  );
}

export default App;
