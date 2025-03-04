import React from "react";
import { AuthLayout } from "../auth/AuthLayout";
import { SignUpForm } from "../auth/SignUpForm";
export const SignUp = () => {
  return (
    <AuthLayout
      title="Create Account"
      subtitle="Join our exclusive aircraft marketplace"
      imageSrc="https://images.unsplash.com/photo-1540962351504-03099e0a754b?ixlib=rb-4.0.3"
    >
      <SignUpForm />
    </AuthLayout>
  );
};
