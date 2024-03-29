import SwiftUI

struct ContentView: View {
    /// Current pirate font
    @State private var pirateFont: Font?
    
    /// Gives detail informations about the current quest
    @State private var gameEngine: GameEngine = GameEngine(currentGameState: .welcome)
    
    @State private var showWelcomeOverlay: Bool = true
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                if geometry.size.height < geometry.size.width {
                    ZStack {
                        Image("MapViewFull")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.9)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            .ignoresSafeArea()
                            .shadow(radius: 10)
                        
                        if !showWelcomeOverlay {
                            GregContentViewComponent(gameEngine: gameEngine, geometry: geometry)
                        }
                    }
                } else {
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            Image(systemName: "rectangle.portrait.rotate")
                                .bold()
                                .font(.largeTitle)
                                .padding(.bottom, 5)
                            Text("Please rotate your \riPad to landscape mode.")
                                .multilineTextAlignment(.center)
                                .bold()
                                .font(.largeTitle)
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }
        .overlay {
            WelcomeOverlay(isVisible: $showWelcomeOverlay)
        }
        .background(.blue)
        .onAppear {
            loadFont()
        }
        
    }
    
    /// Load the Pirate One font from the ressources folder
    func loadFont() {
        let cfURL = Bundle.main.url(forResource: "PirateFont", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        let uiFont = UIFont(name: "PirateFont", size:  30.0)
        pirateFont = Font(uiFont ?? UIFont())
    }
    
    
    
}
