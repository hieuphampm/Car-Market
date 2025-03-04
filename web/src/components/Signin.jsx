import { Link } from "react-router-dom";

const Signin = () => {
  return (
    <div className="flex items-center justify-center min-h-screen bg-gradient-to-br from-purple-500 to-pink-500 p-4">
      <div className="bg-black/50 backdrop-blur-lg p-8 rounded-2xl w-full max-w-lg shadow-lg text-white">
        <h2 className="text-2xl font-bold mb-4">Create Account</h2>
        <p className="text-sm mb-6">Join us and start your journey</p>
        <form>
          <div className="mb-4">
            <label className="block text-sm">Email</label>
            <input type="email" className="w-full p-3 mt-1 rounded-xl bg-black text-white placeholder-gray-400 shadow-inner focus:outline-none focus:ring-2 focus:ring-pink-400" placeholder="Johndoe@gmail.com" />
          </div>
          <div className="mb-4">
            <label className="block text-sm">Password</label>
            <input type="password" className="w-full p-3 mt-1 rounded-xl bg-black text-white placeholder-gray-400 shadow-inner focus:outline-none focus:ring-2 focus:ring-pink-400" placeholder="••••••••" />
          </div>
          <button className="w-full py-3 rounded-xl bg-gradient-to-r from-red-400 to-pink-500 text-white font-semibold shadow-md hover:opacity-90">Sign up</button>
        </form>
        <p className="text-center text-sm mt-6">
          Already have an account? <Link to="/login" className="text-pink-400 hover:underline">Login</Link>
        </p>
      </div>
    </div>
  );
};

export default Signin;
