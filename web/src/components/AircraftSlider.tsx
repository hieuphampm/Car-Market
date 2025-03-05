import React, { useState } from "react";
import { Link } from "react-router-dom";
import { ChevronLeft, ChevronRight } from "lucide-react";
const AircraftSlider = () => {
  const [currentSlide, setCurrentSlide] = useState(0);
  const aircrafts = [
    {
      id: 1,
      name: "Praetor 600",
      price: "$20,500,000",
      status: "Used",
      image:
        "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/aircarft%2FPraetor%20600%2FPraetor%20600.jpg?alt=media&token=fe580cdb-83e1-4398-b7b8-420e1b83621e",
      category: "Private Jet",
    },
    {
      id: 2,
      name: "Boeing 787 Dreamliner",
      price: "$248,300,000",
      status: "New",
      image:
        "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/aircarft%2Fboeing%2FBoeing%20787.jpg?alt=media&token=1d30e258-b32a-41f9-8f94-2b12129600f7",
      category: "Commercial Aircraft",
    },
    {
      id: 3,
      name: "Cessna 510 Citation Mustang",
      price: "$2,325,000",
      status: "Used",
      image:
        "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/aircarft%2FCessna%20510%2FCessna%20510.jpg?alt=media&token=091a78c7-478b-4cd9-a15a-e3270885e644",
      category: "Private Jet",
    },
    {
      id: 4,
      name: "ATR 72 Cargo",
      price: "$23,500,000",
      status: "Used",
      image:
        "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/aircarft%2Fatr-72%2Fatr72.jpg?alt=media&token=6ea2e00a-59ed-4469-a5b6-c02b2ac61bbc",
      category: "Cargo Jet",
    },
  ];
  const visibleAircrafts = aircrafts.slice(currentSlide, currentSlide + 3);
  const nextSlide = () => {
    if (currentSlide < aircrafts.length - 3) {
      setCurrentSlide(currentSlide + 1);
    } else {
      setCurrentSlide(0);
    }
  };
  const prevSlide = () => {
    if (currentSlide > 0) {
      setCurrentSlide(currentSlide - 1);
    } else {
      setCurrentSlide(aircrafts.length - 3);
    }
  };
  return (
    <div className="relative">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {visibleAircrafts.map((aircraft) => (
          <Link
            key={aircraft.id}
            to={`/aircraft/${aircraft.id}`}
            className="group"
          >
            <div className="bg-white rounded-lg overflow-hidden shadow-lg transition-transform transform group-hover:-translate-y-2 duration-300">
              <div className="relative h-48 overflow-hidden">
                <img
                  src={aircraft.image}
                  alt={aircraft.name}
                  className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                />
                <div className="absolute top-4 right-4 bg-blue-600 text-white text-xs font-bold px-2 py-1 rounded">
                  {aircraft.status}
                </div>
              </div>
              <div className="p-6">
                <div className="text-sm text-gray-500 mb-2">
                  {aircraft.category}
                </div>
                <h3 className="text-xl font-bold mb-2">{aircraft.name}</h3>
                <div className="flex justify-between items-center">
                  <span className="text-blue-600 font-bold">
                    {aircraft.price}
                  </span>
                  <span className="text-sm text-gray-500">View Details</span>
                </div>
              </div>
            </div>
          </Link>
        ))}
      </div>
      {/* Navigation Arrows */}
      <button
        onClick={prevSlide}
        className="absolute -left-4 top-1/2 transform -translate-y-1/2 bg-white rounded-full p-2 shadow-lg hover:bg-gray-100 transition-colors"
      >
        <ChevronLeft size={24} />
      </button>
      <button
        onClick={nextSlide}
        className="absolute -right-4 top-1/2 transform -translate-y-1/2 bg-white rounded-full p-2 shadow-lg hover:bg-gray-100 transition-colors"
      >
        <ChevronRight size={24} />
      </button>
    </div>
  );
};
export default AircraftSlider;
