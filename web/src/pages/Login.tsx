import React from "react";
import { AuthLayout } from "../auth/AuthLayout";
import { LoginForm } from "../auth/LoginForm";

const Login = () => {
  return (
    <AuthLayout
      title="Welcome Back"
      subtitle="Sign in to your account to continue"
      imageSrc="https://images.unsplash.com/photo-1583396618422-6e453013caff?ixlib=rb-4.0.3"
    >
      <LoginForm />
    </AuthLayout>
  );
};

export default Login;