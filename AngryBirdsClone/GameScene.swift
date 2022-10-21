//
//  GameScene.swift
//  AngryBirdsClone
//
//  Created by Alihan AÇIKGÖZ on 20.10.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // var bird2 = SKSpriteNode()
    var bird = SKSpriteNode()
    var box5 = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    
    var gameStarted = false
    var originalPosition : CGPoint?
    
    override func didMove(to view: SKView) {
        /*
        let texture = SKTexture(imageNamed: "bird")
        bird2 = SKSpriteNode(texture: texture)
        bird2.position = CGPoint(x: 0, y: 0)
        bird2.size = CGSize(width: 100, height: 100)
        bird2.zPosition = 1
        self.addChild(bird2)
        */
        
        // Fiziksel vücudun sınır döngüsünün nereden itibaren olacağını belirtiyor. Yani bir objeye fizik verdiğimizde o fizik özelliklerinin nereden sonra çalışmasını istemiyorsak orayı belirtiyoruz. Aşağıdaki senaryoda Frame'in yani telefonun ekran çerçevesinin kendisini belirtmektedir.
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .fill
        
        
        
        // Bird
        // GameScene içerisinde oluşuturulan yani kod ile oluşturulmayan spritelar için bu tanımlama şarttır. Fonksiyonun dışarısında tanımladığımız bird değişkenine bir fonksiyon ile birlikte stprite ataması yapıyoruz. Bunu "childNode" fonksiyonu ile yapıyoruz. bizden "withName" isimli bir parametre istiyor. Bu parametre GameScene içerisinde eklediğimiz spritelara verdiğimiz isim. Ardından childNode fonksiyonunu SKSpriteNode olarak cast ediyoruz.
        bird = childNode(withName: "bird") as! SKSpriteNode
        // Ardodan tanımladığımız sprite'ın fiziksel özelliklerini yazmamız lazım.
        let birdTexture = SKTexture(imageNamed: "bird")
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height/14)
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15
        originalPosition = bird.position
        // Bird finish
        
        
        // BOXes
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box5 = childNode(withName: "box5") as! SKSpriteNode
        
        
        let box1Texture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: box1Texture.size().width/6, height: box1Texture.size().height/6)
        let boxMass = 0.4
        
        
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.allowsRotation = true
        box1.physicsBody?.mass = boxMass
        
        
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.allowsRotation = true
        box3.physicsBody?.mass = boxMass
        
        
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.allowsRotation = true
        box3.physicsBody?.mass = boxMass
        
        
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.allowsRotation = true
        box4.physicsBody?.mass = boxMass
        
        
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.allowsRotation = true
        box5.physicsBody?.mass = boxMass
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*let impulseVector = CGVector(dx: 20, dy: 100)
        bird.physicsBody?.applyImpulse(impulseVector)
        bird.physicsBody?.affectedByGravity = true */
        
        if gameStarted == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y - originalPosition!.y)
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                gameStarted = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let birdPhysics = bird.physicsBody {
            if birdPhysics.velocity.dx <= 0.2 && birdPhysics.velocity.dy <= 0.2 && birdPhysics.angularVelocity <= 0.2 && gameStarted == true {
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.angularVelocity = 0
                bird.zPosition = 1
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.position = originalPosition!
                bird.zRotation = CGFloat(0)
                gameStarted = false
            }
        }
    }
}
