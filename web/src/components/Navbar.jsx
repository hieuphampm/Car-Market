import { Link } from 'react-router-dom';

function Navbar() {
  return (
    <nav className="p-4 bg-blue-500 text-white flex justify-between">
      <h1 className="text-2xl font-bold">Aircraft Selling</h1>
      <div>
        <Link className="px-4" to="/">Home</Link>
        <Link className="px-4" to="/listings">Listings</Link>
        <Link className="px-4" to="/about">About</Link>
        <Link className="px-4" to="/login">Login</Link>
      </div>
    </nav>
  );
}
export default Navbar;
