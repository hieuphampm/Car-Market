import React from "react";
import { Plane } from "lucide-react";
export const Categories = () => {
  return (
    <section className="py-16 bg-white">
      <div className="container mx-auto px-4">
        <h2 className="text-3xl font-bold text-[#1A3D7A] mb-12 text-center">
          Featured Categories
        </h2>
        <div className="grid md:grid-cols-3 gap-8">
          {[
            {
              title: "Commercial Aircraft",
              icon: <Plane className="w-12 h-12 text-[#F5C518]" />,
              description:
                "Wide-body and narrow-body aircraft for commercial aviation",
            },
            {
              title: "Private Jets",
              icon: <Plane className="w-12 h-12 text-[#F5C518]" />,
              description:
                "Luxury private jets for executive and personal travel",
            },
            {
              title: "Helicopters",
              icon: <div className="w-12 h-12 text-[#F5C518]" />,
              description: "Versatile rotorcraft for various applications",
            },
          ].map((category, index) => (
            <div
              key={index}
              className="bg-[#F9F9F9] p-6 rounded-lg text-center hover:shadow-lg transition-shadow"
            >
              <div className="mb-4 flex justify-center">{category.icon}</div>
              <h3 className="text-xl font-semibold text-[#1A3D7A] mb-2">
                {category.title}
              </h3>
              <p className="text-gray-600">{category.description}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};
