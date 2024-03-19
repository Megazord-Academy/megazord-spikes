//
//  classe.swift
//  PhysicsTestes
//
//  Created by Bruno Dias on 07/03/24.
//

import Foundation
import RealityKit
import ARKit
class ColorController: ObservableObject{
  // Carrega o objeto 3D importado
    
    var isforcing: Bool = false
  let modelURL = Bundle.main.url(forResource: "teste", withExtension: "usdz")!
  let modelEntity: ModelEntity
    
    
    
    
    let modelURL1 = Bundle.main.url(forResource: "tv_retro", withExtension: "usdz")!
    let modelEntity1: ModelEntity
    
    var wheelShape: ShapeResource
    var axisShape: ShapeResource
   
    var shapes: [ShapeResource]
    
    
   
    
    
  init(){
      modelEntity = try! ModelEntity.loadModel(contentsOf: modelURL)
      modelEntity1 = try! ModelEntity.loadModel(contentsOf: modelURL1)
      
      wheelShape = ShapeResource.generateCapsule(height: 0.5, radius: 0.6/*, Transform(translation: SIMD3(0,1,0))*/)
      axisShape = ShapeResource.generateCapsule(height: 2, radius: 0.2)
      
      
      
      shapes = [/*wheelShape,*/ axisShape/*, wheelShape*/]
      
      
      
      modelEntity.transform = Transform(scale: SIMD3(1,1,1),rotation: simd_quatf(angle: .pi/2, axis: SIMD3(0,1,0)))
  }
    
  func changeModelColor(){
      
      
      
      
      modelEntity.physicsBody = PhysicsBodyComponent(shapes: [axisShape] , mass: 0.5, material: .generate(friction: 0.1, restitution: 0), mode: .dynamic)
      modelEntity.generateCollisionShapes(recursive: true)
      modelEntity.collision = CollisionComponent(shapes: [axisShape])
//      modelEntity.collision = CollisionComponent(shapes: .)

//      modelEntity.components.set(PhysicsBodyComponent(shapes: [axisShape], mass: 1))
//      modelEntity.physicsBody = shapes(modelEntity.physicsBody)
//      modelEntity.physicsBody?.massProperties.mass = 1
      

      print("trocar cor do carrinho")
  }
    func changeForceColor(){

        modelEntity.addTorque(SIMD3(0,0,-0.3), relativeTo: nil)

        
        print("Torque aplicado")
    }
    
    
}
