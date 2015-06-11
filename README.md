ViewTransformer
===================================  

What ViewTransformer can do
-----------------------------------
Using ViewTransformer,you can transform SubClass Of UIView,such as UIImageView,UILabel.
Transforming UIlabel,font size of it would transform automatically itself.

![](https://github.com/scutWolf/ViewTransformer/blob/master/ViewTransformerDemo/demo.gif)

How to use ViewTransformer
-----------------------------------

1.Import first
###
    import "ViewTransformer.h"

2.Init the view transformer with add-icon image and its size 
###
    @property (strong, nonatomic) ViewTransformer *viewTransformer;
###

```objective-c
-(ViewTransformer *)viewTransformer {
    if (!_viewTransformer) {
    //size of transformer
    CGSize size = CGSizeMake(25.0, 25.0);
    _viewTransformer = [[ViewTransformer alloc]initWithIconImage:[UIImage imageNamed:@"addIcon"] size:size];
       [self.view addSubview:_viewTransformer];
    }
    return _viewTransformer;
}
```

3.Set the view to transform:
###
    self.viewTransformer.targetView = targetView;

4.To remove the focus :
###
    self.viewTransformer.targetView = nil;

5.To correct the point of the viewTransformer when the targetView moving or moved:
###
    [self.viewTransformer correctTransformerPoint];
    
6.You can set the border color or border width:
###
    self.viewTransformer.borderColor = [UIColor greenColor];
    self.viewTransformer.borderWidth = 2.0;
