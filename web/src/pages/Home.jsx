import React from "react";
import { Header } from "../components/Header";
import { HeroBanner } from "../components/HeroBanner";
import { AircraftSlider } from "../components/AircraftSlider";
import { Categories } from "../components/Categories";
import { CompanyInfo } from "../components/CompanyInfo";

function Home() {
  return (
    <div className="min-h-screen bg-white">
      <Header />
      <main>
        <HeroBanner />
        <AircraftSlider />
        <Categories />
        <CompanyInfo />
      </main>
    </div>
  );
}

export default Home;