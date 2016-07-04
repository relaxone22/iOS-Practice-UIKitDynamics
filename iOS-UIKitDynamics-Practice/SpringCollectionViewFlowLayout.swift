//
//  SpringCollectionViewFlowLayout.swift
//  iOS-UIKitDynamics-Practice
//
//  Created by tonyliu on 6/30/16.
//  Copyright © 2016 tonyliu. All rights reserved.
//

import UIKit

class SpringCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: Property
    var animator: UIDynamicAnimator!
    var springDamping: CGFloat = 0.5 {
        didSet {
            for bechavior in animator.behaviors {
                let spring = bechavior as! UIAttachmentBehavior
                    spring.damping = springDamping;
            }
        }
    }
    var springFrequency: CGFloat = 0.5 {
        didSet {
            for bechavior in animator.behaviors {
                let spring = bechavior as! UIAttachmentBehavior
                spring.frequency = springFrequency;
            }
        }
    }
    var springResistanceFactor:CGFloat = 200
    
    // MARK: Init
    override init() {
        super.init()
        initialise()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialise()
    }
    
    func initialise() {
        self.animator = UIDynamicAnimator(collectionViewLayout: self)
    }
    
    // MARK: Override
    override func prepareLayout() {
        let contentSize = self.collectionViewContentSize()
        let items = super.layoutAttributesForElementsInRect(CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height))
        
        if animator.behaviors.isEmpty {
            for item in items! {
                let spring = UIAttachmentBehavior(item: item, attachedToAnchor: item.center)
                spring.length    = 0
                spring.damping   = self.springDamping
                spring.frequency = self.springFrequency
                
                self.animator.addBehavior(spring)
            }
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.animator.itemsInRect(rect) as? [UICollectionViewLayoutAttributes]
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return self.animator.layoutAttributesForCellAtIndexPath(indexPath)
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        let scrollView    = self.collectionView
        let scrollDelta   = newBounds.origin.x - scrollView!.bounds.origin.x
        let touchLocation = scrollView?.panGestureRecognizer.locationInView(scrollView)
        
        for behavior in self.animator.behaviors {
            let spring            = behavior as! UIAttachmentBehavior
            let anchorPoint       = spring.anchorPoint
            let distanceFromTouch = CGFloat(fabsf(Float(touchLocation!.x-anchorPoint.x)))
            let scrollResistance  = distanceFromTouch / self.springResistanceFactor
            
            let item              = spring.items.first as! UICollectionViewLayoutAttributes
            var center            = item.center
            center.x += (scrollDelta > 0) ? min(scrollDelta, scrollDelta * scrollResistance)
                                         : max(scrollDelta, scrollDelta * scrollResistance)
            item.center = center
            self.animator.updateItemUsingCurrentState(item)

        }
        return false
    }
}
