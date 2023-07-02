//
//  Shapath.swift
//  Unicalc
//
//  Created by Herve Crespel on 01/09/2022.
//

import CoreGraphics

struct Glypath {
    let starters: [[CGFloat]]       // [x,y] [offset : [x,y]] - chaque offset répète le motif
    let segments: [[CGFloat]]       // [[x,y]]
    
  /*  init(_ points:[[CGFloat]]) {
        start = points[0]
        var segs : [[CGFloat]] = []
        for i in 1..<points.count {
            segs.append(points[i])
        }
        segments = segs
    }*/
}

struct Shapath {
    
    static let adjustment: CGFloat = 0.085
    
    var parts :[Continuouspath]
    
    init(_ value:Int, _ set:[[Glypath]]) {
        let carpath: [Glypath] = set[value]
        var c:[Continuouspath] = []
        for i in 0..<carpath.count {
            let glypath = carpath[i]
            c.append(Continuouspath(glypath))
            if glypath.starters.count > 1 {
                for clone in 1..<glypath.starters.count {
                    c.append(Continuouspath(glypath, clone))
                }
            }
        }
        parts = c

    }
    struct Point {
        let x: CGFloat
        let y: CGFloat
        init(_ px:CGFloat, _ py:CGFloat) {
            x = px
            y = py
        }
    }
    
    enum Segmentype {
        case line
        case curve
    }
    
    struct Segment {
        let line: CGPoint
        let curve: CGPoint
        let control: CGPoint
        let type: Segmentype
        
        init(_ x:CGFloat, _ y:CGFloat) {
            type = .line
            line = CGPoint(x: x, y: y)
            curve = CGPoint(x: 0, y: 0)
            control = CGPoint(x: 0, y: 0)
        }
        init(_ x:CGFloat, _ y:CGFloat, _ cx:CGFloat, _ cy:CGFloat) {
            type = .curve
            line = CGPoint(x: 0, y: 0)
            curve = CGPoint(x: x, y:y)
            control = CGPoint(x: cx, y:cy)
        }
    }
    
    struct Continuouspath {
        let start : Point
        let segments : [Segment]
    
        init(_ path:Glypath,_ clone:Int = 0) {
            let offset = clone > 0 ? path.starters[clone] : [0,0]
            start = Point(path.starters[0][0] + offset[0], path.starters[0][1] + offset[1])
            var seg : [Segment] = []
            for i in 0..<path.segments.count {
                let segpath = path.segments[i]
                if segpath.count == 2 {
                    seg.append(Segment(segpath[0] + offset[0], segpath[1] + offset[1]))
                } else {
                    seg.append(Segment(segpath[0] + offset[0], segpath[1] + offset[1], segpath[2], segpath[3]))
                }
            }
            segments = seg
        }
    }
}
