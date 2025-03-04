import "../App.css";

export default function Home() {
  return (
    <div className="home-container">
      <div className="home-overlay">
        <h1 className="home-title">
          <span className="text-yellow-400">✈</span> Aircraft Marketplace
        </h1>
        <p className="home-subtitle">
          Explore a vast selection of private jets, helicopters, and commercial aircraft. Find your dream aircraft today!
        </p>
        <p className="home-description">
          Whether you're looking for a luxury jet for business travel, a helicopter for personal transport, or a commercial aircraft for your airline, we provide the best deals in the market.
        </p>
      </div>
      <div className="home-buttons">
        <button className="home-button home-button-primary">Browse Listings</button>
        <button className="home-button home-button-secondary">Sell Your Aircraft</button>
      </div>
      <div className="home-footer">
        <p>Trusted by aviation professionals worldwide. Secure transactions, verified sellers, and the best aircraft listings.</p>
      </div>
    </div>
  );
}
