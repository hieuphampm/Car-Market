import React from "react";
import { AuthLayout } from "../auth/AuthLayout";
import { ConsultationForm } from "../auth/ConsultationForm";
export const Consultation = () => {
  return (
    <AuthLayout
      title="Request Consultation"
      subtitle="Get expert guidance on your aircraft purchase"
      imageSrc="https://images.unsplash.com/photo-1559627755-42213a9c5586?ixlib=rb-4.0.3"
    >
      <ConsultationForm />
    </AuthLayout>
  );
};
