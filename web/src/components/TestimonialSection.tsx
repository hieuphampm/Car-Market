import React from "react";
import { Star } from "lucide-react";
const TestimonialSection = () => {
  const testimonials = [
    {
      id: 1,
      name: "Michael Thompson",
      role: "Fleet Manager, Global Airways",
      quote:
        "Aircraft Market helped us find exactly what we needed for our fleet expansion. The process was smooth and transparent from start to finish.",
      avatar: "https://randomuser.me/api/portraits/men/32.jpg",
      rating: 5,
    },
    {
      id: 2,
      name: "Sarah Johnson",
      role: "Private Jet Owner",
      quote:
        "I was impressed by the selection and the expert guidance provided by the Aircraft Market team. They made purchasing my first jet a breeze.",
      avatar: "https://randomuser.me/api/portraits/women/44.jpg",
      rating: 5,
    },
    {
      id: 3,
      name: "Robert Chen",
      role: "CEO, Aviation Solutions",
      quote:
        "We have been partnering with Aircraft Market for over a decade. Their platform consistently delivers quality leads and exceptional service.",
      avatar: "https://randomuser.me/api/portraits/men/68.jpg",
      rating: 4,
    },
  ];
  return (
    <section className="py-16 bg-white">
      <div className="container mx-auto px-4">
        <h2 className="text-3xl font-bold text-center mb-12">
          What Our Customers Say
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {testimonials.map((testimonial) => (
            <div
              key={testimonial.id}
              className="bg-gray-50 p-8 rounded-lg shadow-sm"
            >
              <div className="flex items-center mb-4">
                {[...Array(5)].map((_, i) => (
                  <Star
                    key={i}
                    size={18}
                    className={
                      i < testimonial.rating
                        ? "text-yellow-400 fill-yellow-400"
                        : "text-gray-300"
                    }
                  />
                ))}
              </div>
              <blockquote className="text-gray-700 mb-6">
                &quot;{testimonial.quote}&quot;
              </blockquote>
              <div className="flex items-center">
                <img
                  src={testimonial.avatar}
                  alt={testimonial.name}
                  className="w-12 h-12 rounded-full mr-4"
                />
                <div>
                  <p className="font-bold">{testimonial.name}</p>
                  <p className="text-gray-600 text-sm">{testimonial.role}</p>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};
export default TestimonialSection;
