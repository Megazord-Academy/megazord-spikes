//
//  ContentView.swift
//  testeAumentedReality
//
//  Created by Caio Gomes Piteli on 07/03/24.
//

import SwiftUI
import RealityKit
import ARKit
import UIKit

struct ContentView : View {
    @ObservedObject var modelsController = ArController()

    var body: some View {
        ZStack{
            ARViewContainer(modelsController: modelsController).edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                
                HStack{
                    Button(action: {
                        modelsController.addForceCar()
                    }) {
                        Text("Aplicar força")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Button(action: {
                        modelsController.applyPhysics()
                    }) {
                        Text("Add fisica")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(10)
                    }

                    
                }
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var modelsController: ArController
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)

        // Possibilidando que a ARView reconheça o gesto de clicar na tela
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.tapped)))
        
        // Dando valor as váriaveis do coordinator do contexto
        context.coordinator.arView = arView
        context.coordinator.modelsController = modelsController
        
        // A instrução de procurar plano (coaching) deve aparecer na tela até identificar plano
        arView.addCoaching()
        
        return arView
    }
    
    func makeCoordinator() -> Coordinator{ //MARK: DÚVIDA
        Coordinator()
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {        
        
    }
    
}

//MARK: - Instruções para procurar plano
extension ARView: ARCoachingOverlayViewDelegate {
    
    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = self.session
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        coachingOverlay.goal = .horizontalPlane //Ele so conclui quando acha um plano horizontal
        
        self.addSubview(coachingOverlay)
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {}
    
}


//MARK: - Identifica o ponto que o usuário clicou na tela e transforma esse ponto para coordenada 3D, onde sera colocado o modelo. Pensando em clean code é bom confirmar se deve-se usar um coordinator
class Coordinator {
    
    var arView: ARView?
    var modelsController: ArController?
    
    @objc func tapped(_ recognizer: UITapGestureRecognizer){
        
        guard let arView = arView else { return }
        
        let location = recognizer.location(in: arView) // Recebendo localização do toque na ARview
        
        let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal) // basicamente atribui a variavel "results" onde o toque na view significa em coordenadas 3D
        
        if let result = results.first{
            
            let anchor = AnchorEntity(raycastResult: result) // Setando a ancora para colocar o chão e modelo a partir do resultado do toque
            
            // Creating "floor"
            let floor = ModelEntity(mesh: .generateBox(size: [10, 0.01, 10]))
            floor.generateCollisionShapes(recursive: true)
            floor.physicsBody = PhysicsBodyComponent(shapes: [ShapeResource.generateBox(size: [10, 0.01, 10])], mass: 1000, material: .generate(friction: 0.5, restitution: 0), mode: .static)
            floor.model?.materials = [SimpleMaterial(color: .clear, roughness: 1, isMetallic: false)]
            
            // Colocando o modelo em cima do chão para saber que a física funcionou, ai o modelo vai cair no chão
            modelsController?.modelEntity.position = SIMD3(0,1,0)
            
            // Adicionando o modelo e o chão a cena
            anchor.addChild(modelsController!.modelEntity) // Force unwrap pois garanto que o models vai existir ao passar pelo coordinator
            anchor.addChild(floor) // Toda vez que clicar na tela ele vai adicionar um chão e o modelo 3D. Modificar isso, para que o chão seja sempre o mesmo
            
            arView.scene.anchors.append(anchor) // Adicionando a ancora na ARView, já que o modelo e o chão são filhas da ancora, eles já vem junto
        }
    }
    
}
