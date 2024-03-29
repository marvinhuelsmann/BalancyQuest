//
//  PathComponent.swift
//
//
//  Created by Marvin Hülsmann on 21.01.24.
//

import SwiftUI

struct Line {
    var points: [CGPoint]
    var color: Color
    var lineWidth: CGFloat
}

struct PathComponent: View {
    
    @State var changeCount: Int = 0
    @Binding var lines: [Line]
    @Binding var hasInteractWithSpider: Bool
    @Binding var hasReachedTarget: Bool
    
    var body: some View {
        Canvas { contenxt, size in
            for line in lines {
                var path = Path()
                path.addLines(line.points)
                
                contenxt.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
            }
        }
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged({ value in
            let newPoint = value.location
            if value.translation.width + value.translation.height == 0 {
                checkPosition(pointToCheck: newPoint)
                lines.append(Line(points: [newPoint], color: .white, lineWidth: 7))
            
                if changeCount < 91 {
                    changeCount+=1;
                }
            } else {
                let index = lines.count - 1
                checkPosition(pointToCheck: newPoint)
                lines[index].points.append(newPoint)
                
                if changeCount < 91 {
                    changeCount+=1;
                }
            }
        }))
        
    }
    
    /// Checks whether 2 CGPoints are nearby with a tolerance limit
    /// - Parameters:
    ///   - point1: first point to check
    ///   - point2: second point to check
    ///   - tolerance: Tolerance distance that should also be counted
    /// - Returns: whether there is nearby
    func isPointNearby(_ point1: CGPoint, _ point2: CGPoint, tolerance: CGFloat = 90) -> Bool {
        let distanceX = abs(point1.x - point2.x)
        let distanceY = abs(point1.y - point2.y)

        return distanceX <= tolerance && distanceY <= tolerance
    }

    
    /// Checks the position of an another CGPoint
    /// - Parameter pointToCheck: Current CGPoint of the Line
    func checkPosition(pointToCheck: CGPoint) {
        
        if (pointToCheck.y < 6 || pointToCheck.y > 775) && changeCount >= 90 {
            hasReachedTarget = true
        }
        
        switch pointToCheck {
        case let point where isPointNearby(point, CGPoint(x: 260, y: 240)):
            hasInteractWithSpider = true
        case let point where isPointNearby(point, CGPoint(x: 1040, y: 540)):
            hasInteractWithSpider = true
        case let point where isPointNearby(point, CGPoint(x: 460, y: 180)):
            hasInteractWithSpider = true
        case let point where isPointNearby(point, CGPoint(x: 1109, y: 290)):
            hasInteractWithSpider = true
        case let point where isPointNearby(point, CGPoint(x: 650, y: 350)):
            hasInteractWithSpider = true
        default: break
            
        }
    }
    
}


