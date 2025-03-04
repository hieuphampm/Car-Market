import React from "react";
interface AuthLayoutProps {
  children: React.ReactNode;
  title: string;
  subtitle: string;
  imageSrc: string;
}
export const AuthLayout = ({
  children,
  title,
  subtitle,
  imageSrc,
}: AuthLayoutProps) => {
  return (
    <div className="min-h-screen flex flex-col md:flex-row">
      <div className="md:w-1/2 p-8 md:p-12 flex flex-col justify-center">
        <div className="max-w-md w-full mx-auto">
          <h1 className="text-3xl font-bold text-[#1A3D7A] mb-2">{title}</h1>
          <p className="text-gray-600 mb-8">{subtitle}</p>
          {children}
        </div>
      </div>
      <div className="hidden md:block md:w-1/2 bg-[#1A3D7A]">
        <div className="h-full relative">
          <div className="absolute inset-0 bg-black opacity-40"></div>
          <img
            src={imageSrc}
            alt="Aircraft"
            className="w-full h-full object-cover"
          />
        </div>
      </div>
    </div>
  );
};
