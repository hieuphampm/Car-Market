import React from "react";
import { ChevronLeft, ChevronRight } from "lucide-react";
export const AircraftSlider = () => {
  const aircrafts = [
    {
      id: 1,
      name: "Airbus A350",
      image:
        "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/aircarft%2Fairbus-a350%2Fa350.jpg?alt=media&token=6744c6ac-1f08-4161-bc21-a1b04f6255dd",
      price: "$300.5M",
    },
    {
      id: 2,
      name: "Boeing 787 Dreamliner",
      image:
        "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/aircarft%2Fboeing%2FBoeing%20787.jpg?alt=media&token=1d30e258-b32a-41f9-8f94-2b12129600f7",
      price: "$248.3M",
    },
    {
      id: 3,
      name: "Cessna 510",
      image:
        "https://firebasestorage.googleapis.com/v0/b/computer-shop-management-a2cdd.appspot.com/o/aircarft%2FCessna%20510%2FCessna%20510.jpg?alt=media&token=091a78c7-478b-4cd9-a15a-e3270885e644",
      price: "$23.5M",
    },
  ];
  return (
    <section className="py-16 bg-[#F9F9F9]">
      <div className="container mx-auto px-4">
        <h2 className="text-3xl font-bold text-[#1A3D7A] mb-8">
          Latest Aircraft
        </h2>
        <div className="relative">
          <div className="flex space-x-6 overflow-x-auto pb-4">
            {aircrafts.map((aircraft) => (
              <div
                key={aircraft.id}
                className="min-w-[300px] bg-white rounded-lg shadow-lg"
              >
                <img
                  src={aircraft.image}
                  alt={aircraft.name}
                  className="w-full h-48 object-cover rounded-t-lg"
                />
                <div className="p-4">
                  <h3 className="text-xl font-semibold text-[#1A3D7A]">
                    {aircraft.name}
                  </h3>
                  <p className="text-[#F5C518] font-bold mt-2">
                    {aircraft.price}
                  </p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
};
