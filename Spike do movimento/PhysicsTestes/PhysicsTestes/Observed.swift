//
//  Observed.swift
//  PhysicsTestes
//
//  Created by Bruno Dias on 07/03/24.
//

import SwiftUI
import RealityKit
struct ContentView : View {
    
  @ObservedObject var models = ColorController()
    
    
  var body: some View {
    
    ZStack{
        
      ARViewContainer(models: models).edgesIgnoringSafeArea(.all)
        
        VStack{
            Spacer()
            HStack{
                Button(action: {
                    models.changeForceColor()
                }) {
                    Text("FORCA do CArrinho")
                        .padding() // Adiciona um preenchimento ao redor do texto
                        .background(Color.blue) // Cor de fundo do botão
                        .foregroundColor(.white) // Cor do texto do botão
                        .font(.headline) // Define o tamanho e estilo da fonte
                        .cornerRadius(10) // Define o raio do canto do botão
                }
                
                .padding()
                Button(action: {
                    models.changeModelColor()
                }) {
                    Text("COR DO CARRIN")
                        .padding() // Adiciona um preenchimento ao redor do texto
                        .background(Color.blue) // Cor de fundo do botão
                        .foregroundColor(.white) // Cor do texto do botão
                        .font(.headline) // Define o tamanho e estilo da fonte
                        .cornerRadius(10) // Define o raio do canto do botão
                }
                Spacer()
                Button(action: {
//                    print(models.isforcing)
                    models.isforcing = true
//                    print(models.isforcing)
                }) {
                    Text("BUG")
                        .padding() // Adiciona um preenchimento ao redor do texto
                        .background(Color.blue) // Cor de fundo do botão
                        .foregroundColor(.white) // Cor do texto do botão
                        .font(.headline) // Define o tamanho e estilo da fonte
                        .cornerRadius(10) // Define o raio do canto do botão
                }
            }
        }
    }
  }
}
struct ARViewContainer: UIViewRepresentable {
  @ObservedObject var models: ColorController
    
    
  func makeUIView(context: Context) -> ARView{
      let arView = ARView(frame: .zero)
      arView.debugOptions = [
        .showPhysics
//        ,.showAnchorOrigins
//        ,.showAnchorGeometry
    ]
      
      let floor = ModelEntity(mesh: .generateBox(size: [10, 0.01, 10]))
              
      floor.generateCollisionShapes(recursive: true)
      floor.physicsBody = PhysicsBodyComponent(shapes: [ShapeResource.generateBox(size: [10, 0.1, 20])], mass: 0, material: .generate(friction: 0.05, restitution: 0), mode: .static)
      floor.model?.materials = [SimpleMaterial(color: .clear, isMetallic: false)]
      
      
      // Criar uma entidade que represente a rampa
      let rampaMesh = MeshResource.generateBox(size: [0.5, 0.1, 0.5]) // Exemplo de uma rampa como um cubo
      let rampaEntity = ModelEntity(mesh: rampaMesh)
      rampaEntity.model?.materials = [SimpleMaterial(color: .blue, isMetallic: true)]
      // Posicione, ajuste a escala e rotacione a rampa conforme necessário
      rampaEntity.position = [0, 0, 0] // Posição da rampa
      rampaEntity.scale = [1, 1, 1] // Escala da rampa
      rampaEntity.orientation = simd_quatf(angle: .pi / 4, axis: [0, 1, 0]) // Rotação da rampa (45 graus em torno do eixo Y)
//      ModelEntity.add
      rampaEntity.generateCollisionShapes(recursive: true)
      rampaEntity.physicsBody = PhysicsBodyComponent(shapes: [ShapeResource.generateBox(size: [2, 0.2, 4])], mass: 0, material: .generate(friction: 0.5, restitution: 0.1), mode: .static)
      rampaEntity.position.x = 0
      rampaEntity.position.y = -0.2
      rampaEntity.transform = Transform(scale: SIMD3(1,1,1),rotation: simd_quatf(angle: .pi / 18, axis: SIMD3(0,0,1)))
      
      

      let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
      
      models.modelEntity.position.x = -1
      models.modelEntity.position.y = 1
      
      anchor.addChild(models.modelEntity)
//    anchor.addChild(models.modelEntity1)
      anchor.addChild(floor)
      anchor.addChild(rampaEntity)
    // Add the horizontal plane anchor to the scene
    arView.scene.anchors.append(anchor)
    return arView
  }
    
    func update(context: SceneUpdateContext){
        print("esta entrando")
        if models.isforcing {
            models.modelEntity.addForce(SIMD3(0.01,0,0), relativeTo: nil)

        }
    }

  func updateUIView(_ uiView: ARView, context: Context) {
      print("entrando")
  }
    
    
}
