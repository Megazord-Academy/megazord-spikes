//
//  teste.swift
//  PhysicsTestes
//
//  Created by Bruno Dias on 06/03/24.
//

import SwiftUI
import RealityKit
import ARKit

struct Content1View: View {
    @State private var isARSupported = false
    @State private var showARView = false

    var body: some View {
        ZStack {
            if showARView {
                ARViewWrapper(isARSupported: $isARSupported)
            } else {
                RegularView()
            }

            VStack {
                Spacer()
                Button(action: {
                    showARView.toggle()
                }) {
                    Text(showARView ? "Voltar" : "Visualização AR")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                Button(action: {
//                    ModelEntity.addForce(ModelEntity)
                }) {
                    Text(showARView ? "aplicou?" : "Aplicar forca")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            isARSupported = ARConfiguration.isSupported
        }
    }
}

struct ARViewWrapper: UIViewRepresentable {
    @Binding var isARSupported: Bool

    func makeUIView(context: Context) -> ARView {
        guard isARSupported else {
            return ARView(frame: .zero)
        }
        let arView = ARView(frame: .zero)
//        let box = MeshResource.generateBox(size: 0.2)
//        let material = SimpleMaterial(color: .red, isMetallic: true)
//        let modelEntity = ModelEntity(mesh: box, materials: [material])
//        let anchor = AnchorEntity(world: [0, 0, -1])
//        anchor.addChild(modelEntity)
//        arView.scene.anchors.append(anchor)
        
        let modelName = "robot_walk_idle" // Substitua "object" pelo nome do seu arquivo de modelo 3D
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "usdz")!
        let modelEntity = try! ModelEntity.loadModel(contentsOf: modelURL)
        modelEntity.addForce( SIMD3<Float>(100, 100, -100), relativeTo: nil)

        // Adiciona o objeto 3D à cena
        let anchor = AnchorEntity(world: [0, 0, -1])
        anchor.scale = [2, 2, 1]
        anchor.addChild(modelEntity)
        arView.scene.anchors.append(anchor)
        
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        // Update the view
    }
}

struct RegularView: View {
    var body: some View {
        ZStack {
            ARViewContainer1()
//                        .frame(width: 300, height: 300) // Ajuste o tamanho conforme necessário
//                        .background(Color.white)
//                .scaledToFit()
//                        .frame(width: 300, height: 300, alignment: .center)
                }.background(Color.red)
        
    }
}

struct ARViewContainer1: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        arView.automaticallyConfigureSession = false
        arView.environment.sceneUnderstanding.options.insert(.occlusion)
        
        // Carrega o objeto 3D importado
        let modelName = "robot_walk_idle" // Substitua "object" pelo nome do seu arquivo de modelo 3D
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "usdz")!
        let modelEntity = try! ModelEntity.loadModel(contentsOf: modelURL)
            
        modelEntity.addForce( SIMD3<Float>(100, 100, -100), relativeTo: nil)

        // Adiciona o objeto 3D à cena
        let anchor = AnchorEntity(world: [0, 0, -1])
        anchor.scale = [2, 2, 1]
        anchor.addChild(modelEntity)
        arView.scene.anchors.append(anchor)
        
        
        
        
        
        
        
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
    
//    func applyForceToNode(node: ModelEntity ) {
//        // Acessa o nó para o qual você deseja aplicar a força
//        // Substitua "entity" pelo seu próprio nó
//        let entity = node // Obtenha uma referência ao seu nó
//        
//        // Aplica uma força ao nó na direção especificada
//        node.addForce([0, 0, -100], at: [0, 0, 0], relativeTo: )
//    }

}


#Preview {
    Content1View()
}
