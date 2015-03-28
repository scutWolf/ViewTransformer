ViewTransformerDemo
===================================  

1.Import first
-----------------------------------  
import "ViewTransformer.h"

2.Init the view transformer @property (strong, nonatomic) ViewTransformer *viewTransformer;
-----------------------------------  
###
    -(ViewTransformer *)viewTransformer {

        if (!_viewTransformer) {
          //size of transformer
           CGSize size = CGSizeMake(25, 25);
           _viewTransformer = [[ViewTransformer alloc]initWithSize:size];
           [self.view addSubview:_viewTransformer];
        }
        return _viewTransformer;
    }

3.Set the view to transform:
-----------------------------------  
###
    self.viewTransformer.targetView = targetView;

4.To remove the focus :
-----------------------------------  
###
    self.viewTransformer.targetView = nil;

5.To correct the point of the viewTransformer when the targetView moving of moved:
-----------------------------------  
###
    [self.viewTransformer correctTransformerPoint];
