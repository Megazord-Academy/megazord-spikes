//
//  ARController.swift
//  testeAumentedReality
//
//  Created by Caio Gomes Piteli on 07/03/24.
//

import Foundation
import RealityKit
import ARKit

class ArController: ObservableObject{
    
    // Carrega o objeto 3D importado
    let modelURL = Bundle.main.url(forResource: "nomeDoSeuModeloAqui", withExtension: "usdz")! // em "toy_car" é o nome do modelo 3D carregado no projeto
    let modelEntity: ModelEntity
    
    
    init(){
        modelEntity = try! ModelEntity.loadModel(contentsOf: modelURL)
    }
    
    func applyPhysics(){
        modelEntity.generateCollisionShapes(recursive: true)
        
        modelEntity.physicsBody = PhysicsBodyComponent(massProperties: .default, material: .generate(friction: 0.7, restitution: 0), mode: .dynamic)
        
        modelEntity.physicsBody?.massProperties.mass = 10
      
    }
    
    func addForceCar(){
        /*
         Aqui onde a força é aplicada no modelo (x,y,z) a depender de qual eixo escolher.
         Unidade da força em metros.
        */
        modelEntity.addForce(SIMD3(0.2,0,0), relativeTo: nil)
           
    }
}







