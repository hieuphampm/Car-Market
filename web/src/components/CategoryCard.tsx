import React from "react";
import { Link } from "react-router-dom";
import { ArrowRight } from "lucide-react";
interface CategoryProps {
  category: {
    id: number;
    title: string;
    description: string;
    image: string;
    link: string;
  };
}
const CategoryCard: React.FC<CategoryProps> = ({ category }) => {
  return (
    <Link to={category.link} className="group">
      <div className="bg-white rounded-lg overflow-hidden shadow-lg h-full transition-transform transform group-hover:-translate-y-2 duration-300">
        <div className="relative h-48 overflow-hidden">
          <img
            src={category.image}
            alt={category.title}
            className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
          />
          <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent" />
        </div>
        <div className="p-6">
          <h3 className="text-xl font-bold mb-2">{category.title}</h3>
          <p className="text-gray-600 mb-4">{category.description}</p>
          <div className="flex items-center text-blue-600 font-medium">
            Explore{" "}
            <ArrowRight
              size={16}
              className="ml-2 group-hover:ml-3 transition-all"
            />
          </div>
        </div>
      </div>
    </Link>
  );
};
export default CategoryCard;
