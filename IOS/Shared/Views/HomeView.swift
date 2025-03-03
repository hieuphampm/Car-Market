import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Aircraft List
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(sampleAircrafts) { aircraft in
                            NavigationLink(destination: AircraftDetailView(aircraft: aircraft)) {
                                AircraftCardView(aircraft: aircraft)
                            }
                        }
                    }
                    .padding()
                }

                Spacer()

                // Navigation Buttons
                HStack {
                    NavigationLink(destination: OrdersView()) {
                        NavButtonView(icon: "cart.fill", title: "Orders")
                    }

                    NavigationLink(destination: ProfileView()) {
                        NavButtonView(icon: "person.fill", title: "Profile")
                    }
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("Home")
        }
    }
}

// MARK: - Sample Data
struct AircraftModel: Identifiable {
    let id = UUID()
    let name: String
    let price: String
    let imageName: String
}

let sampleAircrafts = [
    AircraftModel(name: "Boeing 747", price: "$350M", imageName: "airplane"),
    AircraftModel(name: "Airbus A320", price: "$110M", imageName: "airplane"),
    AircraftModel(name: "Gulfstream G650", price: "$65M", imageName: "airplane")
]

// MARK: - Aircraft Card View
struct AircraftCardView: View {
    let aircraft: AircraftModel

    var body: some View {
        VStack {
            Image(systemName: aircraft.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()

            Text(aircraft.name)
                .font(.headline)

            Text(aircraft.price)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(width: 150, height: 180)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

// MARK: - Navigation Button View
struct NavButtonView: View {
    let icon: String
    let title: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 30))
                .padding()

            Text(title)
                .font(.headline)
        }
        .frame(width: 120, height: 120)
        .background(Color.blue.opacity(0.2))
        .cornerRadius(12)
    }
}

// MARK: - Placeholder Views
struct OrdersView: View {
    var body: some View {
        Text("Orders Screen")
            .font(.largeTitle)
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile Screen")
            .font(.largeTitle)
    }
}

struct AircraftDetailView: View {
    let aircraft: AircraftModel

    var body: some View {
        VStack {
            Text(aircraft.name)
                .font(.largeTitle)
                .padding()
            
            Text(aircraft.price)
                .font(.title)
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
